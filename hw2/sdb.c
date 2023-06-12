#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/user.h>
#include <capstone/capstone.h>

#define errquit(m) { perror(m); exit(EXIT_FAILURE); }

struct breakpoint {
    long addr;
    long orig_data;
    bool enabled;
};

#define MAX_BREAKPOINTS 10
struct breakpoint breakpoints[MAX_BREAKPOINTS];
int num_breakpoints = 0;

typedef struct {
    struct user_regs_struct regs;
    unsigned long long start_addr;
    size_t size;
    char* memory;
} Snapshot;

Snapshot latest_snapshot;

Snapshot take_snapshot(pid_t pid) {
    Snapshot snapshot;

    // Read process registers
    ptrace(PTRACE_GETREGS, pid, NULL, &snapshot.regs);

    // Read process memory
    FILE* maps_file;
    char maps_path[256];
    sprintf(maps_path, "/proc/%d/maps", pid);
    maps_file = fopen(maps_path, "r");
    if (maps_file == NULL) {
        errquit("Failed to open maps file");
    }

    char line[256];
    while (fgets(line, sizeof(line), maps_file)) {
        unsigned long long start, end;
        char permissions[5];
        sscanf(line, "%llx-%llx %4s", &start, &end, permissions);
        if (strcmp(permissions, "rw-p") == 0) {
            snapshot.start_addr = start;
            snapshot.size = end - start;
            break;
        }
    }

    snapshot.memory = malloc(snapshot.size);

    for (size_t offset = 0; offset < snapshot.size; offset += sizeof(long)) {
        long data = ptrace(PTRACE_PEEKDATA, pid, snapshot.start_addr + offset, NULL);
        if (data == -1) {
            errquit("Failed to read memory");
        }
        memcpy(snapshot.memory+offset, &data, sizeof(long));
    }

    fclose(maps_file);

    return snapshot;
}

void restore_snapshot(pid_t pid, Snapshot snapshot) {
    // Write process registers
    ptrace(PTRACE_SETREGS, pid, NULL, &(snapshot.regs));

    // Write process memory
    long data;
    for (size_t offset = 0; offset < snapshot.size; offset += sizeof(data)) {
        memcpy(&data, snapshot.memory + offset, sizeof(data));
        ptrace(PTRACE_POKEDATA, pid, snapshot.start_addr + offset, data);
    }
}

void print_instruction(csh handle, pid_t child, uint64_t address, int ninsn) {
    long data;
    unsigned char code[8];
    cs_insn *insn;
    size_t count, offset = 0;

    for (int i = ninsn; i > 0; i--) {
        data = ptrace(PTRACE_PEEKTEXT, child, address+offset, NULL);
        if ((data & 0xFF) == 0xCC) {
            for (int j = 0; j < num_breakpoints; j++) {
                if (breakpoints[j].addr == address+offset) {
                    data = breakpoints[j].orig_data;
                    break;
                }
            }
        }
        memcpy(code, &data, sizeof(code));
        count = cs_disasm(handle, code, sizeof(code), address+offset, 0, &insn);

        if (count > 0 && data != 0) {
            printf("\t%"PRIx64": ", insn[0].address);
            for (size_t k = 0; k < 8; k++) {
                if (k < insn[0].size)
                    printf("%02x ", code[k]);
                else
                    printf("   ");
            }
            printf("%s\t%s\n", insn[0].mnemonic, insn[0].op_str);
            offset += insn[0].size;

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

    // Initialize capstone disassembler
    if (cs_open(CS_ARCH_X86, CS_MODE_64, &handle) != CS_ERR_OK) {
        errquit("Failed to initialize disassembler");
    }

    child = fork();
    if (child == 0) {
        // Child process
        ptrace(PTRACE_TRACEME, 0, NULL, NULL);
        execvp(argv[1], argv + 1);
        errquit("Failed to execute the program");
    } else if (child > 0) {
        // Parent process
        waitpid(child, &status, 0);
        if (!WIFSTOPPED(status)) {
            errquit("The child process failed to start");
        }

        // Get entry point address
        ptrace(PTRACE_GETREGS, child, NULL, &regs);
        uint64_t entry_point = regs.rip;

        printf("** program '%s' loaded. entry point 0x%lx\n", argv[1], entry_point);

        // Read and disassemble the first 5 instructions
        print_instruction(handle, child, entry_point, 5);

        /* handle commands */
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
                for (int i = 0; i < num_breakpoints; i++) {
                    if (!breakpoints[i].enabled) {
                        long int3 = (breakpoints[i].orig_data & 0xFFFFFFFFFFFFFF00) | 0xCC;
                        if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, int3) != 0) {
                            errquit("Failed to reset breakpoint");
                        }
                        breakpoints[i].enabled = true;
                        // printf("** breakpoint at 0x%lx is enabled\n", breakpoints[i].addr);
                    }
                }
                ptrace(PTRACE_GETREGS, child, NULL, &regs);
                for (int i = 0; i < num_breakpoints; i++) {
                    if (breakpoints[i].addr == regs.rip && breakpoints[i].enabled) {
                        printf("** hit a breakpoint 0x%lx\n", breakpoints[i].addr);
                        /* restore break point */
                        if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, breakpoints[i].orig_data) != 0) {
                            errquit("failed to restore break point");
                        }
                        breakpoints[i].enabled = false;
                        break;
                    }
                }
                ptrace(PTRACE_GETREGS, child, NULL, &regs);
                print_instruction(handle, child, regs.rip, 5);
            } else if (strcmp(command, "cont\n") == 0) {
                /* enable break point */
                ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
                waitpid(child, &status, 0);
                for (int i = 0; i < num_breakpoints; i++) {
                    if (!breakpoints[i].enabled) {
                        long int3 = (breakpoints[i].orig_data & 0xFFFFFFFFFFFFFF00) | 0xCC;
                        if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, int3) != 0) {
                            errquit("Failed to reset breakpoint");
                        }
                        breakpoints[i].enabled = true;
                        // printf("** breakpoint at 0x%lx is enabled\n", breakpoints[i].addr);
                    }
                }
                /* handle continuous breakpoint */
                ptrace(PTRACE_GETREGS, child, NULL, &regs);
                bool hit = false;
                for (int i = 0; i < num_breakpoints; i++) {
                    if (breakpoints[i].addr == regs.rip && breakpoints[i].enabled) {
                        printf("** hit a breakpoint 0x%lx\n", breakpoints[i].addr);
                        /* restore break point */
                        if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, breakpoints[i].orig_data) != 0) {
                            errquit("Failed to restore breakpoint");
                        }
                        breakpoints[i].enabled = false;
                        hit = true;
                        break;
                    }
                }
                if (hit) {
                    // printf("** continuous breakpoint\n");
                    print_instruction(handle, child, regs.rip, 5);
                    continue;
                }
                /* continue the execution */
                ptrace(PTRACE_CONT, child, NULL, NULL);
                waitpid(child, &status, 0);
                if (WIFEXITED(status)) {
                    printf("** the target program terminated.\n");
                    break;
                }
                ptrace(PTRACE_GETREGS, child, NULL, &regs);
                if (WSTOPSIG(status) == SIGTRAP) {
                    for (int i = 0; i < num_breakpoints; i++) {
                        if (regs.rip-1 == breakpoints[i].addr && breakpoints[i].enabled) {
                            printf("** hit a breakpoint 0x%lx\n", breakpoints[i].addr);
                            regs.rip--;
                            /* restore break point */
                            if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, breakpoints[i].orig_data) != 0) {
                                errquit("Failed to restore breakpoint");
                            }
                            /* step back */
                            if (ptrace(PTRACE_SETREGS, child, 0, &regs) != 0) {
                                errquit("Failed to set registers");
                            }
                            breakpoints[i].enabled = false;
                            // printf("** breakpoint at 0x%lx is temprorarily disabled\n", breakpoints[i].addr);
                            break;
                        }
                    }
                } else {
                    printf("** stopped 0x%llx, reason: %s\n", regs.rip, strsignal(WSTOPSIG(status)));
                }
                print_instruction(handle, child, regs.rip, 5);
            } else if (strncmp(command, "break ", 6) == 0) {
                // get breakpoint address
                long breakpoint_addr = strtol(command + 6, NULL, 16);
                if (num_breakpoints < MAX_BREAKPOINTS) {
                    /* get original text */
                    long data = ptrace(PTRACE_PEEKTEXT, child, breakpoint_addr, NULL);
                    /* store breakpoint info */
                    ptrace(PTRACE_GETREGS, child, NULL, &regs);
                    if (breakpoint_addr != regs.rip) {
                        struct breakpoint bp = {breakpoint_addr, data, true};
                        breakpoints[num_breakpoints] = bp;
                        num_breakpoints++;
                        // modify the instruction on the address as a breakpoint instruction
                        long int3 = (data & 0xFFFFFFFFFFFFFF00) | 0xCC;
                        if (ptrace(PTRACE_POKETEXT, child, breakpoint_addr, int3) != 0) {
                            printf("** failed to set breakpoint\n");
                            continue;
                        }
                    } else {
                        struct breakpoint bp = {breakpoint_addr, data, false};
                        breakpoints[num_breakpoints] = bp;
                        num_breakpoints++;
                    }
                    printf("** set a breakpoint at 0x%lx\n", breakpoint_addr);
                } else {
                    printf("** maximum number of breakpoints reached\n");
                }
            } else if (strcmp(command, "anchor\n") == 0) {
                // Snapshot process memory and registers
                latest_snapshot = take_snapshot(child);
                printf("** dropped an anchor\n");
            } else if (strcmp(command, "timetravel\n") == 0) {
                printf("** go back to the anchor point\n");

                // Restore original process state
                restore_snapshot(child, latest_snapshot);

                // Print instructions
                ptrace(PTRACE_GETREGS, child, NULL, &regs);
                // disable head breakpoint
                for (int i = 0; i < num_breakpoints; i++) {
                    if (regs.rip == breakpoints[i].addr && breakpoints[i].enabled) {
                        /* restore break point */
                        if (ptrace(PTRACE_POKETEXT, child, breakpoints[i].addr, breakpoints[i].orig_data) != 0) {
                            errquit("Failed to restore breakpoint");
                        }
                        /* step back */
                        if (ptrace(PTRACE_SETREGS, child, 0, &regs) != 0) {
                            errquit("Failed to set registers");
                        }
                        breakpoints[i].enabled = false;
                        // printf("** breakpoint at 0x%lx is temprorarily disabled\n", breakpoints[i].addr);
                        break;
                    }
                }
                ptrace(PTRACE_GETREGS, child, NULL, &regs);
                print_instruction(handle, child, regs.rip, 5);
            } else if (strcmp(command, "exit\n") == 0) {
                break;
            } else {
                printf("Undefined command: %s", command);
            }
        }

        cs_close(&handle);
    } else {
        errquit("Failed to fork");
    }

    return 0;
}