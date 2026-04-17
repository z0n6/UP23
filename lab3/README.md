# Lab 3 — GOT Hijacking 與 Dynamic Symbol Resolution

## 題目描述
課程提供 `chals` 執行檔與 `libpoem.so`，`chals` 的 `main` 會依序呼叫大量的 `code_XXX()` 函式，每個函式只會傳回一個整數；但 `libpoem.so` 裡真正的函式名稱與 `chals` GOT 中看到的 `code_XXX` **對不起來（被 shuffle 過）**。

任務：在 `libsolver.so` 中藉由 `LD_PRELOAD` 搶先在 `init()` 階段被載入，做到：

1. 解析 `/proc/self/maps`，找出 `chals` 主程式的 GOT 範圍。
2. 透過 `mprotect` 把 GOT 改為可寫 (`PROT_READ|WRITE|EXEC`)。
3. `dlopen("libpoem.so")` 之後，依 `shuffle.h` 提供的 `ndat[]` mapping，將 GOT 中的 `code_i` 條目覆寫為 `libpoem.so` 中真正對應的函式位址，讓 `chals` 執行時呼叫到正確的函式。
4. 完成後再把 GOT / text 段的權限 restore。

這個 lab 在練習：動態連結、GOT/PLT 結構、`LD_PRELOAD` 注入、`dlopen/dlsym`、`mprotect`。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `chals.c` | 課程給定的主程式，裡面呼叫一大串 `code_XXX()` |
| `libpoem.c` / `libpoem.h` | 真正包含 `code_XXX()` 實作的 shared library |
| `shuffle.h` | `ndat[]` 對應表：`code_i` 在 `libpoem.so` 中的真實 index |
| `libsolver.c` | 我的解答：hook `init()` 並覆寫 `chals` 的 GOT |
| `search.cpp` / `search` | 輔助工具：在 `ndat[]` 與 offset 表之間互查 |
| `getgot.py` | 用 pwntools 的 `ELF` 解析 `chals` 的 GOT，產生 `off[]` 陣列的小工具 |
| `got.txt` | `getgot.py` 輸出的結果留底 |
| `Makefile` | 編譯 `chals`、`libpoem.so`、`libsolver.so` 的規則 |
| `pow.py` / `submit.py` | PoW 與 submission script |

## 編譯 / 執行方式
```bash
make                # 產生 chals, libpoem.so, libsolver.so
make run            # 直接跑 chals（會壞掉，因為 code_XXX 錯亂）
make test           # LD_PRELOAD=./libsolver.so ./chals，驗證 hijack 是否正確
```

## 解題思路 / 備註
- **找 GOT 範圍**：parse `/proc/self/maps`，只看屬於 `chals` 本體的 mapping。第一段 `r--p` 通常是 `.rodata`/`.got.plt` 前半，連續的 `r--p` 加總成 GOT 的結束；`r-xp` 是 text 段，用來之後 restore。
- **覆寫 GOT**：`memcpy(got_addr + off[ndat[i]], &func, 8)`，其中 `off[i]` 是 `chals` 中 `code_i` GOT entry 的相對位移，`ndat[i]` 是該欄真正應指向的 `libpoem.so` symbol index。
- **`dlsym` 名稱**：`sprintf(symbol, "code_%d", i)` 取 `libpoem.so` 中的真實 symbol。
- 由於整個流程是在 `init()` constructor 裡做，`chals` 進 `main` 時 GOT 已經修好。
- `search.cpp` 是純粹的 debug 工具，主要是把 `ndat[]` 與 `off[]` 雙向查表一下，方便我在做 lab 的時候對照資料。
- 坑：`chals` 的 text 段 `r-xp` 也要在 `mprotect` restore 成唯讀執行，避免之後 page permission 出錯。
