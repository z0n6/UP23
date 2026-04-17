# Lab 5 — Linux Kernel Module: `kshram` 共享記憶體裝置

> *Does Sharing Memories Make Us Feel Closer?*
>
> 課程連結：[2023 UNIX Programming Lab05](https://md.zoolab.org/s/n2iYIHC7z)

## 題目描述
撰寫一個 Linux kernel module `kshram.ko`，建立 8 個 character device `/dev/kshram0` … `/dev/kshram7`，支援以下操作：

- `open` / `close` / `read` / `write`：基本 file_operations。
- `mmap`：把該裝置背後的 kernel buffer 直接 map 到 user space，達成 user <-> kernel 的共享記憶體。
- `ioctl` 支援三個命令：
  - `KSHRAM_GETSLOTS`：回傳裝置總數 (8)。
  - `KSHRAM_GETSIZE`：回傳該裝置目前的 buffer 大小。
  - `KSHRAM_SETSIZE`：透過 `krealloc` 重新調整 buffer 大小。
- `proc_fs`：額外在 `/proc` 下提供 `seq_file`，列出每個裝置的 index 與目前大小。

整個題目在 qemu + custom initramfs 環境下驗證，主要練習：

- kernel module 骨架（`module_init` / `module_exit`、`MODULE_LICENSE`）。
- `alloc_chrdev_region` + `class_create` + `device_create` 的 char device 註冊流程。
- `remap_pfn_range` 將 `kzalloc/krealloc` 配到的 contiguous buffer 直接 map 給 user。
- `unlocked_ioctl`、`proc_ops` (kernel 5.6+)、`seq_file`。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `kshram/kshram.c` | kernel module 主體 |
| `kshram/kshram.h` | `KSHRAM_GETSLOTS` / `KSHRAM_GETSIZE` / `KSHRAM_SETSIZE` 的 ioctl 定義 |
| `kshram/Makefile` | 透過 `dist/modulebuild` 進行 out-of-tree module 編譯 |
| `dist.tbz` | 課程提供的 kernel + rootfs + build 環境 |
| `qemu.sh` | 啟動 qemu 用的 script（被 `.gitignore` 排除） |
| `submit.py` / `pow.py` | 上傳與 PoW 腳本 |

> 注意：`dist/` 解壓後的內容、重打包的 `newrootfs.cpio.bz2`、`qemu.sh` 都被 `.gitignore` 排除，不會進 repo。

## 開發環境 / 執行方式

### 1. 初始化
```bash
tar -xvjf dist.tbz                 # 解開課程提供的 dist 包
sudo apt install qemu-system-x86
chmod +x qemu.sh
```

### 2. 編譯 kernel module
```bash
cd kshram && make && cd ..
```

### 3. 重打包 initramfs
```bash
cd dist
bzip2 -dc rootfs.cpio.bz2 | cpio -id rootfs    # 解開 rootfs
cp ../kshram/kshram.ko rootfs/modules/         # 放入 module
cd rootfs
find . | cpio -H newc -o | bzip2 -9 > ../newrootfs.cpio.bz2
```
> 別忘了把 `qemu.sh` 裡 `-initrd` 後面指向的檔名改為 `newrootfs.cpio.bz2`。

### 4. 跑 qemu 並載入 module
```bash
./qemu.sh
# 於 qemu 中：
insmod  /modules/kshram.ko
cat     /proc/kshram
rmmod   kshram
```

## 解題思路 / 備註
- 8 個 device 的識別用 `f->f_path.dentry->d_name.name[6] - '0'`（檔名 `kshramN` 的第 7 個字元）來取 index，簡單粗暴。
- `mmap` 使用 `remap_pfn_range` + `virt_to_page(devices[i].data)`，限制一次 map 最多 `PAGE_SIZE`；要處理大區段應該用 `vm_insert_page` 逐頁 map 才合理，這裡為了過 lab 就先簡化。
- `KSHRAM_SETSIZE` 直接 `krealloc(..., GFP_KERNEL)`，若 user 傳入的 size 過大可能 fail，目前的錯誤處理還不完整。
- `/proc/kshram` 使用 `single_open` + `seq_printf` 列出 `%02d: %ld\n`，對應 8 個 slot。
- 用 `class_create` + `devnode` callback 把裝置權限設為 `0666`，省去每次 `chmod` 的麻煩。
