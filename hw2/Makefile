CC=gcc
CFLAGS=-g -Wall -lcapstone

FILES:=$(wildcard *.c)
PROGS:=$(FILES:.c=)

all: $(PROGS)

%: %.c
	$(CC) -o $@ $< $(CFLAGS)

clean:
	rm $(PROGS)