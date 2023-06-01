#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include <signal.h>
#include <syscall.h>
#include <sys/ptrace.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/reg.h>
#include <sys/user.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

#define MAX_LENGTH 1000

void increaseBinaryString(char* str) {
    int length = strlen(str);

    for (int i = length - 1; i >= 0; i--) {
        if (str[i] == '0') {
            str[i] = '1';
            break;
        } else {
            str[i] = '0';
        }
    }
}

void getString(pid_t pid, unsigned long address, char buffer[]) {
    int offset = 0;

    while (1) {
        long word = ptrace(PTRACE_PEEKDATA, pid, address + offset, NULL);
        for (int i = 0; i < sizeof(long); ++i) {
            buffer[offset + i] = *((char*)(&word) + i);
            if (buffer[offset + i] == '\0') { 
                // Null byte encountered, end of string
                return;
            }
        }
        offset += sizeof(long);
    }
}

void replaceString(pid_t pid, unsigned long address, const char* replacement) {
    char buffer[MAX_LENGTH];
    int offset = 0;

    // Determine length of original string
    while (1) {
        long word = ptrace(PTRACE_PEEKDATA, pid, address + offset, NULL);
        for (int i = 0; i < sizeof(long); ++i) {
            buffer[offset + i] = *((char*)(&word) + i);
            if (buffer[offset + i] == '\0') {
                // Null byte encountered, end of string
                break;
            }
        }
        offset += sizeof(long);

        if (buffer[offset - 1] == '\0') {
            break;
        }
    }

    // Allocate memory for the new string
    char* newString = malloc(strlen(replacement) + 1);
    strcpy(newString, replacement);

    // Write the new string to memory
    offset = 0;
    int bytesWritten = 0;
    while (bytesWritten < strlen(newString) + 1) {
        long originalWord = ptrace(PTRACE_PEEKDATA, pid, address + offset, NULL);
        for (int i = 0; i < sizeof(long); ++i) {
            *((char*)(&originalWord) + i) = newString[bytesWritten];
            bytesWritten++;
            if (bytesWritten >= strlen(newString) + 1) {
                // End of string reached, write back to memory
                ptrace(PTRACE_POKEDATA, pid, address + offset, originalWord);
                free(newString);
                return;
            }
        }
        // Write the modified word back to memory
        ptrace(PTRACE_POKEDATA, pid, address + offset, originalWord);
        offset += sizeof(long);
    }

    free(newString);
}

void procmsg(const char* format, ...)
{
    va_list ap;
    fprintf(stdout, "[%d] ", getpid());
    va_start(ap, format);
    vfprintf(stdout, format, ap);
    va_end(ap);
}

void run_target(const char* programname)
{
    procmsg("target started. will run '%s'\n", programname);

    /* Allow tracing of this process */
    if (ptrace(PTRACE_TRACEME, 0, 0, 0) < 0) {
        perror("ptrace");
        return;
    }

    /* Replace this process's image with the given program */
    execl(programname, programname, (char *)NULL);
}

void run_debugger(pid_t child_pid)
{
    int wait_status;
    struct user_regs_struct regs, snapshot;
    unsigned long long int magic_addr;

    procmsg("debugger started\n");

    /* Wait for child to stop on its first instruction */
    wait(&wait_status);

    /* Obtain and show child's instruction pointer */
    ptrace(PTRACE_GETREGS, child_pid, 0, &regs);
    procmsg("Child started. RIP = 0x%08x\n", regs.rip);

    /* Let the child run to the breakpoint and wait for it to
    ** reach it
    */
    ptrace(PTRACE_CONT, child_pid, 0, 0);

    int ntrap = 0;
    for (;;) {
        wait(&wait_status);
        if (WIFSTOPPED(wait_status)) {
            if (WSTOPSIG(wait_status) == SIGTRAP) {
                /* See where the child is now */
                ptrace(PTRACE_GETREGS, child_pid, 0, &regs);
                ++ntrap;

                if (ntrap == 2) { /* store address of magic */
                    magic_addr = regs.rax;
                    procmsg("Trap %d: find magic at %llx\n", ntrap, magic_addr);
                }
                if (ntrap == 4) { /* snapshot */
                    snapshot = regs;
                    procmsg("Trap %d: store registers snapshot\n", ntrap);
                }
                if (ntrap >= 5 && (int) regs.rax < 0 && ntrap <= 2052) {
                    ptrace(PTRACE_SETREGS, child_pid, 0, &snapshot);
                    char magic[11];
                    getString(child_pid, magic_addr, magic);
                    // printf("magic is %s\n", magic);
                    increaseBinaryString(magic);
                    replaceString(child_pid, magic_addr, magic);
                }
                ptrace(PTRACE_CONT, child_pid, 0, 0);
            } else {
                procmsg("%s\n", strsignal(WSTOPSIG(wait_status)));
            }
            continue;
        }
        break;
    }

    /* The child can continue running now */
    ptrace(PTRACE_CONT, child_pid, 0, 0);

    wait(&wait_status);
    if (WIFEXITED(wait_status)) {
        procmsg("Child exited\n");
    } else if(WIFSIGNALED(wait_status)) {
        procmsg("signal !!!\n");
    } else {
        procmsg("Unexpected signal. %s \n",  strsignal(WSTOPSIG(wait_status)));
    }
 } 

int main(int argc, char** argv)
{
    pid_t child_pid;

    if (argc < 2) {
        fprintf(stderr, "Expected a program name as argument\n");
        return -1;
    }

    child_pid = fork();
    if (child_pid == 0)
        run_target(argv[1]);
    else if (child_pid > 0)
        run_debugger(child_pid);
    else {
        perror("fork");
        return -1;
    }

    return 0;
}