# UNIX Programming (2023, NYCU)

這個 repository 收錄 2023 春 陽明交大 *UNIX Programming* 課程的 lab 與 homework 實作與筆記。每個 lab/hw 子目錄都附有獨立的 `README.md` 說明題目、檔案結構與解題思路。

## 目錄

| 目錄 | 主題 | 快速連結 |
| --- | --- | --- |
| `lab1/` | Proof-of-Work + 四則運算挑戰（pwntools 入門） | [README](./lab1/README.md) |
| `lab2/` | 遞迴搜尋含 magic number 的檔案（POSIX 目錄 API） | [README](./lab2/README.md) |
| `lab3/` | GOT Hijacking（`LD_PRELOAD` + `dlopen`/`dlsym`） | [README](./lab3/README.md) |
| `lab4/` | Seccomp sandbox + shellcode/stack leak | [README](./lab4/README.md) |
| `lab5/` | Linux kernel module：`kshram` 共享記憶體裝置 | [README](./lab5/README.md) |
| `lab6/` | x86-64 組合語言 shell sort | [README](./lab6/README.md) |
| `lab7/` | Return-Oriented Programming shell | [README](./lab7/README.md) |
| `lab8/` | `ptrace` 動態修改子行程記憶體 | [README](./lab8/README.md) |
| `hw1/`  | **Secured API Call**：`LD_PRELOAD` + GOT hijacking sandbox | [README](./hw1/README.md) |
| `hw2/`  | **Simple Instruction-Level Debugger** (`ptrace` + capstone) | [README](./hw2/README.md) |

## 通用工具

- `pow.py`：每個 lab 目錄下都有一份，用來解課程伺服器的 SHA-1 Proof-of-Work（`hashlib` brute force 直到 `sha1(prefix+i)` 前 6 hex chars 為 `000000`）。
- `submit.py`：透過 `pwntools.remote` 把解答（程式碼 / 執行檔 / 組合語言）上傳到 `up23.zoolab.org` 對應 port 的 judge。
- Judge server host：`up23.zoolab.org`；各 lab 用不同 port（見各子目錄的 `submit.py`）。

## 環境需求

- Linux x86-64（部分題目依賴特定 ABI、`seccomp`、`ptrace` 等）。
- `gcc`、`make`、`python3`、`pwntools`。
- Lab 3：`libunwind-dev`。
- Lab 4：`libseccomp-dev`。
- Lab 5：`qemu-system-x86`，以及課程提供的 `dist.tbz`（Linux kernel + rootfs build 環境）。
- HW2：`libcapstone-dev`。

## 備註

- `.gitignore` 已排除 lab 5 的 `dist/`、`dist.tbz` 解壓產物與 `qemu.sh`（含本機 qemu 路徑），這些項目需自行從課程處取得。
- 各子目錄裡的 README 以繁體中文撰寫，包含：題目描述、檔案說明、編譯/執行方式、解題思路 / 備註。
