# HW1 — Secured API Call：用 `LD_PRELOAD` + GOT Hijacking 實作 Sandbox

## 題目描述
實作 `sandbox.so`，透過 `LD_PRELOAD` 被 `launcher` 載入後，攔截目標程式的以下 API 並依 `SANDBOX_CONFIG` 指定的 blacklist 過濾：

| Hook 的 API | 規則 |
| --- | --- |
| `open` | 若打開的（已 follow symlink 的）路徑在 `open-blacklist` → 回 `-1`, `errno=EACCES` |
| `read` | 把每次讀到的內容 append 到 `{pid}-{fd}-read.log`；若讀到 `read-blacklist` 的關鍵字（可跨多次 read） → 關閉 fd、回 `-1`, `errno=EIO` |
| `write` | 把每次寫出的內容 append 到 `{pid}-{fd}-write.log` |
| `connect` | 若對端 IP:PORT 屬於 `connect-blacklist` → 回 `-1`, `errno=ECONNREFUSED` |
| `getaddrinfo` | 若 hostname 屬於 `getaddrinfo-blacklist` → 回錯誤 |
| `system` | 額外的限制（見 spec） |

必要條件：

- 必須透過 **hook `__libc_start_main`** 做初始化，再呼叫真正的 `__libc_start_main`。
- `sandbox.so` 裡不能有跟被 hook 的 API 同名的 symbol → 用 **GOT hijacking**（修改目標程式 GOT 中對應 symbol 的欄位）來攔截，而不是靠 dlsym weak symbol。
- log 寫入指定的 `LOGGER_FD`（由 `launcher` 傳進來的環境變數）。

本次作業主要練習：

- dynamic loader 流程 (`__libc_start_main` 是所有動態連結 ELF 的 glibc 進入點)。
- 解析 ELF：`.dynamic`、`.rela.plt`、`.dynsym` / `.dynstr`，找出 GOT 中某個 symbol 的位置。
- `mprotect` 改 GOT 權限後覆寫對應 entry。
- 對 `read` 實作跨 chunk 的 keyword 偵測（用 slide window 緩衝區，不能只在單一 buffer 裡比對）。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `sandbox.c` | 我的 sandbox 實作主體（362 行） |
| `Makefile` | 編譯 `sandbox.so`，解壓 `hw1testcase.zip`，順便 `objdump` sandbox.so |
| `launcher` | 課程提供的執行 wrapper（設 `LD_PRELOAD` + 傳 env） |
| `config.txt` | 範例設定檔，內含四種 blacklist 區塊 |
| `spec.md` | 作業原始規格 |
| `01` ~ `08` | 範例測資 shell script（跑 `./launcher ./sandbox.so config.txt <cmd>`） |
| `hw1testcase.zip` | 官方測資打包（`make testcase` 會解壓到 `testcase/`） |

## 編譯 / 執行方式
```bash
make                                      # 產生 sandbox.so，並解壓 testcase
./launcher ./sandbox.so config.txt <cmd>  # 執行時自動 hook API

# 逐題測試
./01    # cat /etc/passwd  → 應被 blacklist 擋下
./02    # cat /etc/hosts   → 正常讀取、留 log
./03    # cat .../Amazon_Root_CA_1.pem → 讀到 BEGIN CERTIFICATE 就中斷
./05    # wget http://google.com          → DNS or connect 被擋
./06    # wget https://www.nycu.edu.tw    → connect 443 被擋
...
```

## 解題思路 / 備註
- **`__libc_start_main` hook**：`dlsym(RTLD_NEXT, "__libc_start_main")` 取真正的 symbol，保存 pointer。我的 hook 先讀 `SANDBOX_CONFIG` 解析 blacklist、做 GOT rewriting，再 `return real(main, argc, argv, ...)`。
- **GOT rewriting**：對 `/proc/self/maps` 找目標可執行檔的 base；parse 其 `.dynamic` 取得 `DT_PLTREL/DT_JMPREL/DT_STRTAB/DT_SYMTAB`；scan `.rela.plt`，找名稱符合 `open/read/write/connect/...` 的條目，然後 `mprotect` 讓 GOT 可寫後把對應 entry 替換成 `my_open` / `my_read` / ...。
- **`read` 跨 chunk 比對**：保留長度為 `len(keyword)-1` 的 tail buffer，每次新 read 進來時先把 tail 拼到前面一起 `strstr`。若命中就 `close(fd)` 並 `errno=EIO`。
- **log file**：第一次遇到某個 fd 就 `open("{pid}-{fd}-read.log", O_CREAT|O_APPEND|O_WRONLY)`，之後每次 read 成功就 `write` 實際讀到的 bytes。
- **symlink**：`open` 的 blacklist 檢查要用 `realpath(pathname, buf)` 先 resolve，避免 user 用 `/etc/passwd` 的 symlink 繞過。
- **小坑**：hijack `connect` 要先解析 `struct sockaddr_in` 的 `sin_addr` / `sin_port`（注意 byte order），`AF_INET6` 也要考慮。`getaddrinfo` 的 blacklist 用 hostname 比對即可。
- `LOGGER_FD` 由 launcher 傳入，所有 `[logger] open(...) = ...` 訊息都 `dprintf(logger_fd, ...)` 寫入。
