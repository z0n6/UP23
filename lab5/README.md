# Does Sharing Memories Make Us Feel Closer?
[2023 UNIX Programming Lab05](https://md.zoolab.org/s/n2iYIHC7z)
## Development environment
* Init
```
tar -xvjf dist.tbz # Unpack `dist.tbz` package
apt install qemu-system-x86
chmod +x qemu.sh
```

* To boot the Linux kernel in a virtual machine
```
./qemu.sh
```

* To change `initramfs` image
```
cd dist
bzip2 -dc rootfs.cpio.bz2 | cpio -id rootfs # extracting files from the archive
# add your file into rootfs
cd rootfs
find . | cpio -H newc -o | bzip2 -9 > ../newrootfs.cpio.bz2 # re-pack the image
```

> you need change file behind -initrd in qemu so that it will use newrootfs.cpio.bz2 as new `initramfs`

* To install and remove modules in `qemu` virtual machine
```
insmod <module_path>
rmmod <module_path>
```