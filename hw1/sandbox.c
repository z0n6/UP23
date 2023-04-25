#include <dlfcn.h>
#include <elf.h>
#include <errno.h>
#include <fcntl.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define MAX_BUF_SIZE 16384
#define MAX_MSG_SIZE 1024
#define MAX_NAME_LEN 128
#define errquit(m) { perror(m); exit(EXIT_FAILURE); }

static int DEBUG = 0;
static char *APIList[] = {"open", "read", "write", "connect", "getaddrinfo", "system"};

typedef int (main_func_t)(int, char *, char **);
static int (*orig___libc_start_main)(main_func_t main_func, int argc, char **ubp_av, void (*init_func)(void), void (*fini_func)(void), void (*rtld_fini_func)(void), void *stack_end);

int my_open(const char *pathname, int flags, mode_t mode) {
    char *config_file = getenv("SANDBOX_CONFIG");
    char buf[MAX_BUF_SIZE];
    int logger_fd = atoi(getenv("LOGGER_FD"));
    int fd;

    if (flags != O_CREAT) mode = NULL;

    // Call the original open function if the config file is not set
    if (config_file == NULL) {
        return open(pathname, flags, mode);
    }

    // Read the config file to determine if the file should be opened
    FILE *fp = fopen(config_file, "r");
    if (fp == NULL) {
        perror("my_open/fopen");
        exit(EXIT_FAILURE);
    }
    while (fgets(buf, MAX_BUF_SIZE, fp) != NULL) {
        if (strstr(buf, pathname) != NULL) {
            errno = EACCES;
            fclose(fp);

            dprintf(logger_fd, "[logger] open(\"%s\", %d, %d) = -1\n", pathname, flags, mode);
            return -1;
        }
    }
    fclose(fp);

    // Call the original open function if the file is not denied by the config file
    fd = open(pathname, flags, mode);

    dprintf(logger_fd, "[logger] open(\"%s\", %d, %d) = %d\n", pathname, flags, mode, fd);
    return fd;
}

ssize_t my_read(int fd, void *buf, size_t count) {
    char *config_file = getenv("SANDBOX_CONFIG");
    int logger_fd = atoi(getenv("LOGGER_FD"));
    char config[MAX_BUF_SIZE];
    
    // Create/open log file
    char log_file[MAX_NAME_LEN];
    snprintf(log_file, sizeof(log_file), "%d-%d-read.log", getpid(), fd);
    FILE *log_fp = fopen(log_file, "a");
    if (!log_fp) errquit("my_read/fopen/log_file");

    // Call the original read function
    ssize_t sz = read(fd, buf, count);

    // Load keyword blacklist from config file
    FILE *fp = fopen(config_file, "r");
    if (!fp) errquit("my_read/fopen/config_file");
    int begin_read_blacklist = 0;
    while (fgets(config, MAX_BUF_SIZE, fp) != NULL) {
        char *s = config, *line, *saveptr;
        while ((line = strtok_r(s, "\n\r", &saveptr)) != NULL) { s = NULL;
            if (strstr(line, "BEGIN read-blacklist") != NULL) {
                begin_read_blacklist = 1;
            } else if (strstr(line, "END read-blacklist") != NULL) {
                begin_read_blacklist = 0;
            }

            if (begin_read_blacklist && strstr(buf, line) != NULL) {
                errno = EIO;
                sz = -1;
                close(fd);
                fclose(fp);
                fclose(log_fp);

                dprintf(logger_fd, "[logger] read(%d, %p, %ld) = -1\n", fd, buf, count);
                return -1;
            }
        }
    }
    fclose(fp);

    fwrite(buf, sizeof(char), sz, log_fp);
    fclose(log_fp);

    dprintf(logger_fd, "[logger] read(%d, %p, %ld) = %ld\n", fd, buf, count, sz);
    return sz;
}

ssize_t my_write(int fd, const void *buf, size_t n) {
    int logger_fd = atoi(getenv("LOGGER_FD"));

    // Create/open log file
    char log_file[MAX_NAME_LEN];
    snprintf(log_file, sizeof(log_file), "%d-%d-write.log", getpid(), fd);
    FILE *log_fp = fopen(log_file, "a");
    if (!log_fp) errquit("my_write/fopen/log_file")
    fseek(log_fp, 0, SEEK_END);

    // Call the original read function
    ssize_t sz = write(fd, buf, n);
    if (sz < 0) return sz;

    fwrite(buf, sizeof(char), sz, log_fp);
    fclose(log_fp);

    dprintf(logger_fd, "[logger] write(%d, %p, %ld) = %ld\n", fd, buf, n, sz);
    return sz;
}

int my_connect(int fd, const struct sockaddr *addr, socklen_t len) {
    char *config_file = getenv("SANDBOX_CONFIG");
    int logger_fd = atoi(getenv("LOGGER_FD"));
    char buf[MAX_BUF_SIZE];

    // Convert addr to ip:port
    char ip_str[INET_ADDRSTRLEN];
    char req[MAX_MSG_SIZE];
    int port;
    if (addr->sa_family == AF_INET) {
        struct sockaddr_in *addr_in = (struct sockaddr_in *) addr;
        inet_ntop(AF_INET, &addr_in->sin_addr, ip_str, sizeof(ip_str));
        port = ntohs(addr_in->sin_port);
    } else if (addr->sa_family == AF_INET6) {
        struct sockaddr_in6 *addr_in6 = (struct sockaddr_in6 *) addr;
        inet_ntop(AF_INET, &addr_in6->sin6_addr, ip_str, sizeof(ip_str));
        port = ntohs(addr_in6->sin6_port);
    } else {
        errquit("my_connect/unknown family type");
    }
    snprintf(req, MAX_MSG_SIZE, "%s:%d", ip_str, port);
    dprintf(logger_fd, "Request %s\n", req);
    
    // Read the config file to determine if the IP and PORT is blocked
    FILE *fp = fopen(config_file, "r");
    if (fp == NULL) errquit("my_connect/fopen/config_file");
    int begin_connect_blacklist = 0;
    while (fgets(buf, MAX_BUF_SIZE, fp) != NULL) {
        char *s = buf, *line, *saveptr;
        while ((line = strtok_r(s, "\n\r", &saveptr)) != NULL) { s = NULL;
            if (strstr(line, "BEGIN connect-blacklist") != NULL) {
                begin_connect_blacklist = 1;
                continue;
            } else if (strstr(line, "END connect-blacklist") != NULL) {
                begin_connect_blacklist = 0;
                break;
            }

            if (begin_connect_blacklist) {
                char *bname, *saveptr2;
                int bport;
                bname = strtok_r(line, ":", &saveptr2);
                bport = atoi(strtok_r(NULL, ":", &saveptr2));

                // [TODO] block request if needed
                struct hostent *host = gethostbyname(bname);
                if (host == NULL) errquit("my_connect/gethostbyname failed");
                char **addr_list = host->h_addr_list;
                for (int i = 0; addr_list[i]; i++) {
                    if (strcmp(ip_str, inet_ntoa(*(struct in_addr *) addr_list[i])) == 0 && port == bport) {
                        errno = ECONNREFUSED;
                        fclose(fp);
                        dprintf(logger_fd, "[logger] connect(%d, \"%s\", %d) = -1\n", fd, ip_str, len);
                        return -1;
                    }
                }
            }
        }
    }
    fclose(fp);

    // Call the original read function
    int ret = connect(fd, addr, len);

    dprintf(logger_fd, "[logger] connect(%d, \"%s\", %d) = %d\n", fd, ip_str, len, ret);
    return ret;
}

int my_getaddrinfo(const char *name, const char *service, const struct addrinfo *req, struct addrinfo **pai) {
    char *config_file = getenv("SANDBOX_CONFIG");
    int logger_fd = atoi(getenv("LOGGER_FD"));
    char buf[MAX_BUF_SIZE];
    
    int ret = getaddrinfo(name, service, req, pai);

    // Read the config file to determine if the IP and PORT is blocked
    FILE *fp = fopen(config_file, "r");
    if (fp == NULL) errquit("my_connect/fopen/config_file");
    int begin_connect_blacklist = 0;
    while (fgets(buf, MAX_BUF_SIZE, fp) != NULL) {
        char *s = buf, *line, *saveptr;
        while ((line = strtok_r(s, "\n\r", &saveptr)) != NULL) { s = NULL;
            if (strstr(line, "BEGIN getaddrinfo-blacklist") != NULL) {
                begin_connect_blacklist = 1;
            } else if (strstr(line, "END getaddrinfo-blacklist") != NULL) {
                begin_connect_blacklist = 0;
            }

            if (begin_connect_blacklist && (strstr(line, name) != NULL)) {
                fclose(fp);
                dprintf(logger_fd, "[logger] getaddrinfo(\"%s\", \"%s\", %p, %p) = %d\n", name, service, req, pai, EAI_NONAME);
                return EAI_NONAME;
            }
        }

    }
    fclose(fp);

    dprintf(logger_fd, "[logger] getaddrinfo(\"%s\", \"%s\", %p, %p) = %d\n", name, service, req, pai, ret);
    return ret;
}

int my_system(const char *command) {
    int logger_fd = atoi(getenv("LOGGER_FD"));

    dprintf(logger_fd, "[logger] system(\"%s\")\n", command);

    return system(command);
}

int __libc_start_main(main_func_t main,
                      int argc, char **argv,
                      void (*init) (void),
                      void (*fini) (void),
                      void (*rtlf_fini) (void),
                      void (*stack_end)) {

    char buf[MAX_BUF_SIZE];

    if (DEBUG) printf(":argv\n");
    for (int i = 0; i < argc; i++) {
        if (DEBUG) printf("%d: %s\n", i, argv[i]);
    }

    // Get Base
    int MAP_FD, MAP_SZ;
    if ((MAP_FD = open("/proc/self/maps", O_RDONLY)) < 0) errquit("open /proc/self/maps")
    if ((MAP_SZ = read(MAP_FD, buf, sizeof(buf)-1)) < 0) errquit("read /proc/self/maps");
    buf[MAP_SZ] = 0;
    close(MAP_FD);

    if (DEBUG) printf("\n: /proc/self/maps\n");
    if(DEBUG) printf("%s\n", buf);
    char *s = buf, *line, *saveptr;
    long base_start = 0, base_end = 0;
    long prot_start = 0, prot_end = 0;
    int npages = 0;
    long page_start[8];
    char path[MAX_MSG_SIZE];
    while ((line = strtok_r(s, "\n\r", &saveptr)) != NULL) { s = NULL;
        if (sscanf(line, "%lx-", &page_start[npages++]) != 1) errquit("page start");
        if (strstr(line, argv[0]) == NULL) break;
        if (strstr(line, " r--p ")) {
            if (base_start == 0) {
			    if(sscanf(line, "%lx-%lx %*s %*s %*s %*s %s", &base_start, &base_end, path) != 3) errquit("get_base");
            }
        } else if (strstr(line, " rw-p ")) {
            if(sscanf(line, "%lx-%lx ", &prot_start, &prot_end) != 2) errquit("get_base/got");
        }
    }

    if (DEBUG) printf("%lx - %lx\n", prot_start, prot_end);

    void *base = (int *) base_start;
    void *prot = (int *) prot_start;
    if (DEBUG) printf("base: %p\npath: %s\n", base, path);
    
    memset(buf, 0, sizeof(buf));

    if (DEBUG) printf("\n# pages = %d\n", npages);
    for (int i = 0; i < npages; i++) {
        if (DEBUG) printf("[%d] %lx\n", i, page_start[i]);
    }

    // GOT Hijack
    char cmd[2048];
    if (DEBUG) printf("\n: readelf\n");
    if (DEBUG) printf("func\t\toffset\n");
    unsetenv("LD_PRELOAD");
    
    // snprintf(cmd, sizeof(cmd), "readelf -r %s", path);
    // if (DEBUG) system(cmd);
    
    for (int i = 0; i < sizeof(APIList)/sizeof(APIList[0]); i++) {
        snprintf(cmd, sizeof(cmd), "readelf -r %s | grep -w '%s'", path, APIList[i]);
        if (DEBUG) system(cmd);

        snprintf(cmd, sizeof(cmd), "readelf -r %s | grep -w '%s' | awk '{printf $1}'", path, APIList[i]);
        
        // printf("command: %s\n", cmd);

        FILE *fp = popen(cmd, "r");
        unsigned long offset = 0;
        if (fp == NULL) errquit("popen");
        if (!fgets(buf, MAX_BUF_SIZE, fp)) {
            if (DEBUG) printf("%-16s-\n", APIList[i]);
            continue;
        }

        offset = strtoul(buf, NULL, 16);

        pclose(fp);
        if (DEBUG) printf("%-16s%-16lx\n", APIList[i], offset);
        
        // determine the region for mprotect
        int page;
        for (page = 0; (unsigned long) base + offset > page_start[page]; page++);
        page--;

        // Replace the address in GOT
        void *func;
        if (mprotect(base + page_start[page] - page_start[0], page_start[page+1] - page_start[page], PROT_READ | PROT_WRITE | PROT_EXEC) < 0) errquit("mprotect/open");
        if (strcmp(APIList[i], "open") == 0) { // open    
            func = my_open;
        } else if (strcmp(APIList[i], "read") == 0) {
            func = my_read;
        } else if (strcmp(APIList[i], "write") == 0) {
            func = my_write;
        } else if (strcmp(APIList[i], "connect") == 0) {
            func = my_connect;
        } else if (strcmp(APIList[i], "getaddrinfo") == 0) {
            func = my_getaddrinfo;
        } else if (strcmp(APIList[i], "system") == 0) {
            func = my_system;
        } else {
            errquit("__libc_start_main/unknown API function");
        }
        memcpy(base + offset, &func, sizeof(func));

        if (mprotect(base + page_start[page] - page_start[0], page_start[page+1] - page_start[page], PROT_READ) < 0) errquit("mprotect/close");
    }
    if (DEBUG) printf("\n");

    // recover memory protection
    if (mprotect(prot, prot_end - prot_start, PROT_READ | PROT_WRITE) < 0) errquit("mprotect/recover");

    if (setenv("LD_PRELOAD", "./sandbox.so", 1) < 0) errquit("__libc_start_main/setenv");

    if (DEBUG) printf("=========== START ===========\n");
    orig___libc_start_main = dlsym(RTLD_NEXT, "__libc_start_main");
    return orig___libc_start_main(main, argc, argv, init, fini, rtlf_fini, stack_end);
}