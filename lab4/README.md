# Lab 4 — Stack Leak / Shellcode 繞過 Seccomp 取得 FLAG

## 題目描述
遠端服務 `remoteguess.c` 的邏輯：

1. 讓 user 上傳一段 `solver` 二進位 (raw bytes, 可指定大小)。
2. 用 `mmap(PROT_READ|WRITE|EXEC)` 放入這段程式碼，`fork` 子行程後先 **啟動 seccomp sandbox**（只允許 `write`、`brk`、`getrandom`、`newfstatat`、`exit`、`exit_group`）。
3. 在子行程中以 `fptr(printf)` 呼叫 user 上傳程式的一段 function（偏移由 user 指定），並把 `printf` 當參數丟進去。
4. 回到父行程後，用 `getrandom` 產生 32-bit 隨機 magic，要求 user「猜」這個數字。若猜中就 `open("/FLAG")` 並印出內容。

關鍵觀察：子行程 (solver) 與父行程共用同一個 stack/heap frame 結構（fork 之後父行程接著跑 `guess()`，stack 配置類似）。子行程裡可以透過 format string `printf` 洩漏 stack 上的 canary / rbp / return address，甚至可以嘗試直接把「未來會被父行程用到」的區段 leak 出來。

本 lab 主要練習：

- **Seccomp sandbox** 的限制下如何選擇可用的 syscall（`write` via `printf` 還能用）。
- **Stack layout leak**：用 `*(uint64_t *)((void *)&ptr + offset)` 讀堆疊上的資料。
- 傳遞 `printf` 函式指標作為唯一可用的 I/O 通道。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `remoteguess.c` | 題目伺服器的原始碼（了解 seccomp 規則、stack 配置） |
| `solver.c` | 我的解答：透過偏移讀取 stack 上的 canary / rbp / ra，印回給 user |
| `solver_sample.c` | 官方提供的 solver 範例（只印 hello world） |
| `Makefile` | 編譯 solver 同時 `objdump -D -M intel` 產出 `.s` 以便計算偏移 |
| `submit.py` / `submit2.py` | 兩種 submit 形式（送整個 binary vs. 送 asm 的片段） |
| `pow.py` | PoW 共用模組 |

## 編譯 / 執行方式
```bash
make                 # 產生 solver / solver_sample 以及對應的 .s
make submit          # 把 solver 上傳（整支 ELF）
make submit_asm      # 只上傳 asm 片段
```

## 解題思路 / 備註
- 我的 `solver()` 不做複雜的事，只用 `fptr(format, ...)` 把 `*(&ptr + 0x8/0x10/0x18)` 三個位置的 qword 印出來，對應 canary、saved rbp、return address。
- 真正要取得 FLAG 的關鍵在於：父行程在子行程被 killed / 結束後會要求 user 輸入猜測，而 `magic` 在記憶體中實際佔據固定偏移；透過 leak 出來的 pointer 比對可以推出 magic 的值（或是透過 `read()` 的 `\0` padding bug 把先前留下的資料再讀回來）。
- `submit.py` 與 `submit2.py` 的差別：前者直接把 `solver` ELF 整支傳進去並告訴伺服器 `solver()` 的 offset；後者只挑出 asm 片段上傳，體積小且不必擔心 ELF header。
- 小坑：seccomp 禁掉 `open` / `read` / 大部分 syscall，debug 時只能用 `fptr(...)` 把資訊倒回 stdout。
