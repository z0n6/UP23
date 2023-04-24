CC=gcc
CFLAGS=-g -Wall -static
FILES=solver

all: $(FILES)

%: %.c
	$(CC) -o $@ $^ $(CFLAGS)

clean: 
	rm $(FILES)