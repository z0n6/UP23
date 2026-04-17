# Lab 7 — Return-Oriented Programming (ROP) Shell

## 題目描述
`ropshell.c` 會：

1. 用 `mmap(PROT_READ|WRITE|EXEC)` 配置 `10 * 0x10000` bytes 的「code」區段，填滿隨機 bytes，並在其中某個隨機位置寫入 `0xc3050f`（`syscall; ret`）。
2. `mprotect` 把整段 code 設為 `PROT_READ|EXEC`（之後就不可寫入，只能當作 gadget 來源）。
3. 印出此 code 段的起始位址 `P` 與隨機種子（time）。
4. 進入 shell：讓 user 送入最多 4 KB 的 bytes，當成 stack 內容，把 `rsp` 指到那段 buffer，清空所有通用暫存器後 `ret`。
5. 限時 60 秒，想辦法讓 syscall 跑起來做任意事（典型目標：`execve("/bin/sh", ...)` 或 `open/read/write` 讀 flag）。

可以把這個 lab 想成：伺服器只提供一張**隨機的程式碼地圖**，user 必須自己從中挑出可用的 ROP gadgets 組合出想要的行為。

學到：

- ROP 基本概念與 gadget 搜尋。
- 如何用 syscall gadget + constant pool (stack 上的資料) 實現 `execve`。
- `time(0)` 當 `srand` 種子 + client 端重現隨機 memory 內容的實作技巧。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `ropshell.c` | 題目伺服器端原始碼（了解 memory layout / seccomp 等約束） |
| `ropshell` | 編譯好的 target 執行檔 |
| `submit.py` | 解題 + 上傳 payload 的 pwntools script |
| `pow.py` | PoW 共用模組 |

## 執行方式
```bash
./submit.py
# 或本機測試
./ropshell
```

`submit.py` 裡會：

1. 拿到伺服器回傳的 `timestamp` 與 code base 位址。
2. 用同樣的 `srand(timestamp)` 在 client 端本地重現那段 random code。
3. 掃描裡面的 2/3-byte gadget，挑需要的組出 ROP chain（例如設 `rdi/rsi/rdx`、呼叫 `execve`）。
4. 最後把 ROP chain 當作 `read()` 的 input 送過去，搶在 60 秒的 timeout 前 trigger shell。

## 解題思路 / 備註
- **重現隨機 code**：伺服器 `srand(time(0))` 寫滿 code 段，所以只要知道 `time()` 就能在本地用相同演算法 (`rand()<<16 | (rand()&0xffff)`) 重建整段 memory，然後離線找 gadget。
- **找 gadget**：可以透過 `ROPgadget` 或自己對 buffer 做 pattern scan。常用目標：`pop rdi; ret`、`pop rsi; ret`、`pop rdx; ret`、`syscall; ret`。
- **execve("/bin/sh")**：把 `"/bin/sh\0"` 字串夾帶在 ROP stack 上（user controlled），再 `pop rdi = ptr`、`xor rsi, rsi`、`xor rdx, rdx`、`mov rax, 0x3b`、`syscall`。
- **固定 syscall gadget**：題目本身會在 code 段中塞一個已知 `0xc3050f` (`syscall; ret`)，所以只要掃出它的位置就能直接用作最後一步。
- 時限 60 秒內要完成 gadget scan + ROP chain 組合，scan 用 dict / hash 加速比較安全。
