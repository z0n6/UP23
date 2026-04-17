# Lab 2 — 遞迴搜尋含 Magic Number 的檔案

## 題目描述
在任意目錄下，遞迴尋找「內容包含指定 magic number（字串）」的檔案，把符合條件的路徑一行一行輸出。主要練習：

- C 語言的檔案與目錄操作：`opendir`、`readdir`、`fopen`、`fgets`、`fstat` 等 POSIX API。
- 判斷 `dirent->d_type` 來遞迴子目錄。
- 處理 `.` / `..` 特殊目錄項目。

另外本 lab 還要將編譯好的 `solver` 透過 `submit.py` 上傳到課程伺服器 (`up23.zoolab.org:10081`) 進行自動判題，因此連同 PoW 一起整合在 `submit.py` 裡。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `solver.c` | 主程式，實作 `find_magic_number(path, magic_number)` 遞迴搜尋 |
| `Makefile` | 以 `gcc -static -Wall -g` 編譯 `solver` |
| `pow.py` | PoW 爆破共用模組（同 Lab 1） |
| `submit.py` | 透過 pwntools 上傳 `solver` 執行檔的 submission script |

## 編譯 / 執行方式
```bash
make           # 產生 ./solver
./solver <路徑> <magic-number>
# 範例：./solver /tmp deadbeef

# 上傳執行檔給判題伺服器
./submit.py ./solver
```

`Makefile` 使用 `-static` 是為了讓伺服器端不需要額外的 shared library 就能執行。

## 解題思路 / 備註
- 用 `strstr(buf, magic)` 對每一行做子字串比對；若檔案內含 magic 則立刻 `break` 跳出該檔案的讀取迴圈並印路徑。
- 檔案路徑組合用 `sprintf(filepath, "%s/%s", path, dirp->d_name)`，原則上要注意 `PATH_MAX` 與 buffer 大小（這裡用 `char filepath[1024]`）。
- 透過 `dirp->d_type == DT_DIR` 判斷是否遞迴，比起每個檔案都 `stat()` 再判斷效率較好。
- 小坑：`.` / `..` 一定要跳過，不然會無窮遞迴；`fclose(fp)` 需在 `fopen` 成功時才呼叫（目前程式有在 `fp == NULL` 時仍會 `fclose`，算是可改進之處）。
