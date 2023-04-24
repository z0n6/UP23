#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>

#define err_quit(m) { perror(m); exit(-1); }

void find_magic_number(const char *path, const char *magic_number) {
    DIR *dp;
    struct dirent *dirp;

    if ((dp = opendir(path)) == NULL) {
        err_quit("Could not open directory");
    }

    while ((dirp = readdir(dp)) != NULL) {
        char filepath[1024];
        sprintf(filepath, "%s/%s", path, dirp->d_name);

        if (strcmp(dirp->d_name, ".") != 0 && strcmp(dirp->d_name, "..") != 0) {
            if (dirp->d_type == DT_DIR) find_magic_number(filepath, magic_number);
            else {
                FILE *fp = fopen(filepath, "r");
                if (fp != NULL) {
                    char buf[1024];
                    while (fgets(buf, sizeof(buf), fp) != NULL) {
                        if (strstr(buf, magic_number) != NULL) {
                            printf("%s\n", filepath);
                            break;
                        }
                    }
                }
                fclose(fp);
            }
        }
    }

    closedir(dp);
}

int main(int argc, char **argv) {
    if (argc != 3) {
        err_quit("usage: ./sovler /path/to/the/files/direcrory magic-number");
    }

    find_magic_number(argv[1], argv[2]);

    return 0;
}