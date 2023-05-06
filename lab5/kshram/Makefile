
obj-m     += kshrammod.o
ccflags-y += -DEXPORT_SYMTAB

all: kshram
	make -C ../dist/modulebuild M=$(PWD) modules

kshram: kshram.c
	$(CROSS_COMPILE)gcc -o $@ $< -Wall -static

clean:
	rm -f kshram
	make -C ../dist/modulebuild M=$(PWD) clean

install: all
	mkdir -p ../rootfs/modules
	cp kshram kshrammod.ko ../rootfs/modules
