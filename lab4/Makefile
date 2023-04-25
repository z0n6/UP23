CC=gcc
CFLAGS=-g -Wall
FILES=solver solver_sample

all: $(FILES)

%: %.c
	$(CC) -o $@ $^ $(CFLAGS)
	objdump -D $@ -M intel > $@.s

submit:
	./submit.py solver

submit_asm:
	./submit2.py

clean: 
	-rm -rf __pycache__
	-rm *.s
	-rm $(FILES)
