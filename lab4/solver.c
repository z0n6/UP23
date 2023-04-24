#include <stdio.h>

typedef int (*printf_ptr_t)(const char *format, ...);

void solver(printf_ptr_t fptr) {
	unsigned long *ptr = 0;
	fptr("canary = %016lx\nrbp = %016lx\nra = %016lx\n", *(__uint64_t *)((void *) &ptr + 0x8), *(__uint64_t *)((void *) &ptr + 0x10), *(__uint64_t *)((void *) &ptr+0x18));
}

int main() {
	char fmt[16] = "** main = %p\n";
	printf(fmt, main);
	solver(printf);
	return 0;
}
