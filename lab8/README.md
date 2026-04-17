# Lab 8 — `ptrace` 動態修改子行程的記憶體

## 題目描述
寫一個 `runner`，以 `ptrace` 控制子行程：

1. `fork()` 後子行程呼叫 `PTRACE_TRACEME` 並 `execl(programname)`，父行程變成 debugger。
2. 子行程被 ptrace 監控後，會在預先埋好的 `int3 (0xcc)` 斷點停下（`SIGTRAP`）。
3. 父行程用 `PTRACE_GETREGS/SETREGS/PEEKDATA/POKEDATA` 讀寫子行程的暫存器與記憶體，逐步：
   - 在第 2 個 trap：記錄 `rax` 當作「magic 字串的位址」。
   - 在第 4 個 trap：把當下的 registers snapshot 下來。
   - 在第 5 個 trap 之後、若 `rax < 0` 則代表答案不對，把 registers 還原成 snapshot、並將 magic 字串當成 binary counter `+1` 後寫回，形成「重試」的迴圈。
4. 當猜對時跳出迴圈讓子行程繼續跑完，印出 flag。

主要練習：

- `ptrace` 基本操作：`PTRACE_TRACEME`、`PTRACE_CONT`、`PTRACE_GETREGS`、`PTRACE_SETREGS`、`PTRACE_PEEKDATA`、`PTRACE_POKEDATA`。
- 子行程 signal 處理：`wait(&status)` + `WIFSTOPPED` + `WSTOPSIG`。
- 透過 `ptrace` 以 word (8 bytes) 為單位來讀寫 C string。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `runner.c` | 我的解答，實作 debugger 邏輯 |
| `Makefile` | 用 `-static-pie -g -Wall` 編譯 runner |
| `submit.py` / `pow.py` | 上傳 runner 到伺服器的 script |

## 編譯 / 執行方式
```bash
make
./runner <target-program>

# 上傳
./submit.py ./runner
```

## 解題思路 / 備註
- `increaseBinaryString` 把 magic 當作 `"01..."` 的二進位字串當計數器使用：從最右邊開始找第一個 `'0'` 變 `'1'`，途中遇到 `'1'` 則變 `'0'`，實作 little-endian `+1` 的效果。
- `getString` / `replaceString` 以 `ptrace(PTRACE_PEEKDATA, ...)` / `POKEDATA` 每次 8 bytes 處理，遇到 `'\0'` 就停。若 replacement 比 original 短要自己補 `\0`（這裡是透過上層把 magic 改變後原長度一致）。
- 第 2 個 trap 時 `rax` 存著 magic 指標，第 4 個 trap snapshot registers，`ntrap >= 5` 且 `(int)rax < 0` 代表「答錯」，就從 snapshot 重啟、把 magic 加一再試，最多嘗試到 `ntrap <= 2052` 次（對應 11-byte 二進位字串的搜索空間）。
- 小坑：`rax` 是 unsigned long 但題目裡的「錯誤回傳值」會是 signed `-1`，要記得強制 cast `(int) regs.rax` 判斷；否則永遠為真/假。
- 題目的 target 程式裡預埋了多個 `int3` breakpoint，不需要自己打 `0xcc`，debugger 只需要計算 trap 次數。
