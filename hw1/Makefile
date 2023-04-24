CC = gcc
CFLAG = -g -Wall -D_GNU_SOURCE -fPIC
LDFLAGS = -lunwind -lunwind-$(shell uname -m)
PROGS = sandbox.so

all: launcher testcase $(PROGS)

launcher: 
	chmod +x launcher

testcase:
	unzip hw1testcase.zip

sandbox.so: sandbox.c
	$(CC) -o $@ -shared $(CFLAG) $(LDFLAGS) $^
	cp $@ testcase

sandbox.s: sandbox.so
	objdump -D sandbox.so -m intel > sandbox.s

clear:
	-rm *.log *.html*

clean:
	-make clear
	-rm $(PROGS)
	-rm -rf testcase
