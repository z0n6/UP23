CC = gcc
CFLAG = -static-pie -g -Wall
PROGS = runner

all: $(PROGS)

runner: runner.c
	gcc -o runner runner.c $(CFLAG)

clean:
	rm $(PROGS)
