#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/user.h>
#include <capstone/capstone.h>

struct breakpoint {
    long addr;
    long orig_data;
    bool enabled;
};

#define MAX_BREAKPOINTS 10
struct breakpoint breakpoints[MAX_BREAKPOINTS];
int num_breakpoints = 0;

struct snapshot {
    struct user_regs_struct regs;
    unsigned char code[5];
};

struct snapshot latest_snapshot;

void print_instruction(csh handle, pid_t child, uint64_t address, int ninsn) {
    long data;
    unsigned char code[8]; // Assuming the maximum instruction size is 8 bytes
    cs_insn *insn;
    size_t count, offset = 0;

    for (int i = ninsn; i > 0; i-=count) {
        data = ptrace(PTRACE_PEEKTEXT, child, address+offset, NULL);
        memcpy(code, &data, sizeof(code));
        count = cs_disasm(handle, code, sizeof(code), address+offset, 0, &insn);

        if (count > 0) {
            size_t c_off = 0;
            size_t j;
            for (j = 0; j < count && j < i; j++) {
                printf("\t%"PRIx64": ", insn[j].address);
                for (size_t k = 0; k < 8; k++) {
                    if (k < insn[j].size)
                        printf("%02x ", code[k+c_off]);
                    else
                        printf("   ");
                }
                printf("%s\t%s\n", insn[j].mnemonic, insn[j].op_str);
                offset += insn[j].size;
                c_off += insn[j].size;
            }

            cs_free(insn, count);
        } else {
            printf("** the address is out of the range of the text section.\n");
            break;
        }
    }
}

int main(int argc, char *argv[]) {
    setbuf(stdin, NULL);
    setbuf(stdout, NULL);
    if (argc < 2) {
        printf("Usage: %s <program>\n", argv[0]);
        return 1;
    }

    pid_t child;
    int status;
    struct user_regs_struct regs;
    csh handle;
    unsigned char code[8]; // Assuming the maximum instruction size is 8 bytes

    // Initialize capstone disassembler
    if (cs_open(CS_ARCH_X86, CS_MODE_64, &handle) != CS_ERR_OK) {
        printf("** failed to initialize disassembler\n");
        return 1;
    }

    child = fork();
    if (child == 0) {
        // Child process
        ptrace(PTRACE_TRACEME, 0, NULL, NULL);
        execvp(argv[1], argv + 1);
        printf("** failed to execute the program\n");
        return 1;
    } else if (child > 0) {
        // Parent process
        waitpid(child, &status, 0);
        if (!WIFSTOPPED(status)) {
            printf("** the child process failed to start\n");
            return 1;
        }

        // Get entry point address
        ptrace(PTRACE_GETREGS, child, NULL, &regs);
        uint64_t entry_point = regs.rip;

        printf("** program '%s' loaded. entry point 0x%lx\n", argv[1], entry_point);

        // Read and disassemble the first 5 instructions
        print_instruction(handle, child, entry_point, 5);

        while (1) {
            char command[100];
            printf("(sdb) ");
            fgets(command, sizeof(command), stdin);

            if (strcmp(command, "si\n") == 0) {
                /* single step */
                ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
                waitpid(child, &status, 0);
                if (WIFEXITED(status)) {
                    printf("** the target program terminated.\n");
                    break;
                }
            } else if (strcmp(command, "cont\n") == 0) {
                /* enable break point */
                ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
                waitpid(child, &status, 0);
                for (int i = 0; i < num_breakpoints; i++) {
                    if (!breakpoints[i].enabled) {
                        long int3 = (breakpoints[i].orig_data & 0xFFFFFFFFFFFFFF00) | 0xCC;
                        if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, int3) != 0) {
                            printf("** failed reset breakpoint\n");
                            return 1;
                        }
                        breakpoints[i].enabled = true;
                    }
                }
                /* continue the execution */
                ptrace(PTRACE_CONT, child, NULL, NULL);
                waitpid(child, &status, 0);
                if (WIFEXITED(status)) {
                    printf("** the target program terminated.\n");
                    break;
                }
            } else if (strncmp(command, "break ", 6) == 0) {
                // get breakpoint address
                long breakpoint_addr = strtol(command + 6, NULL, 16);
                if (num_breakpoints < MAX_BREAKPOINTS) {
                    /* get original text */
                    long data = ptrace(PTRACE_PEEKTEXT, child, breakpoint_addr, NULL);
                    /* store breakpoint info */
                    struct breakpoint bp = {breakpoint_addr, data, true};
                    breakpoints[num_breakpoints] = bp;
                    num_breakpoints++;
                    // 修改位址上的指令為斷點指令
                    long int3 = (data & 0xFFFFFFFFFFFFFF00) | 0xCC;
                    if (ptrace(PTRACE_POKETEXT, child, breakpoint_addr, int3) != 0) {
                        printf("** failed to set breakpoint\n");
                        return 1;
                    }
                    printf("** set a breakpoint at 0x%lx\n", breakpoint_addr);
                } else {
                    printf("** maximum number of breakpoints reached\n");
                }
                continue;
            } else if (strcmp(command, "exit\n") == 0) {
                break;
            } else if (strcmp(command, "anchor\n") == 0) {
                // Save current state
                latest_snapshot.regs = regs;
                for (int i = 0; i < 5; i++) {
                    long data = ptrace(PTRACE_PEEKTEXT, child, entry_point + i*8, NULL);
                    memcpy(latest_snapshot.code, &data, sizeof(code));
                }
                printf("** dropped an anchor\n");
                continue;
            } else if (strcmp(command, "timetravel\n") == 0) {
                // Restore state
                ptrace(PTRACE_SETREGS, child, NULL, &latest_snapshot.regs);
                for (int i = 0; i < 5; i++) {
                    ptrace(PTRACE_POKETEXT, child, entry_point + i, latest_snapshot.code[i]);
                }
                printf("** go back to the anchor point\n");
            }

            ptrace(PTRACE_GETREGS, child, NULL, &regs);
            if (WIFSTOPPED(status)) {
                if (WSTOPSIG(status) == SIGTRAP) {
                    for (int i = 0; i < num_breakpoints; i++) {
                        if (regs.rip-1 == breakpoints[i].addr && breakpoints[i].enabled) {
                            printf("** hit a breakpoint 0x%lx\n", breakpoints[i].addr);
                            regs.rip--;
                            /* restore break point */
                            if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, breakpoints[i].orig_data) != 0) {
                                printf("** failed to restore break point\n");
                                return 1;
                            }
                            /* step back */
                            if (ptrace(PTRACE_SETREGS, child, 0, &regs) != 0) {
                                printf("** failed to set registers\n");
                                return 1;
                            }
                            breakpoints[i].enabled = false;
                            break;
                        }
                    }
                } else {
                    printf("** stopped 0x%llx, reason: %s\n", regs.rip, strsignal(WSTOPSIG(status)));
                }
            }

            // Read and disassemble the first 5 instructions
            print_instruction(handle, child, regs.rip, 5);
        }

        cs_close(&handle);
    } else {
        printf("** fork failed\n");
        return 1;
    }

    return 0;
}