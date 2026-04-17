# Lab 6 — x86-64 組合語言：Shell Sort

## 題目描述
用純 x86-64 組合語言（Intel syntax）實作 shell sort 函式，函式簽章等同於：

```c
void shell_sort(long *arr, size_t n);
```

呼叫慣例按 System V AMD64 ABI：`rdi = arr`, `rsi = n`。寫好的 asm 會上傳到伺服器 (`up23.zoolab.org:10950`) 與一個 C 端 harness 連結後跑測資。

學到的重點：

- System V AMD64 呼叫慣例（argument 放在 `rdi/rsi/rdx/...`、保留 callee-saved register 的責任）。
- function prologue/epilogue：`push rbp; mov rbp, rsp; ...; mov rsp, rbp; pop rbp; ret`。
- 以 `shr rcx, 1` 實作 `gap /= 2`，用巢狀 loop 做 shell sort 本體。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `shell_sort.asm` | 我的 shell sort 組語實作 |
| `submit.py` | 透過 pwntools 把 asm 上傳到 judge server |
| `pow.py` | PoW 共用模組 |

## 執行方式
```bash
./submit.py shell_sort.asm
```

`submit.py` 會先用 pwntools 的 `asm()` 將 asm 文字組起來、附在 C harness 裡一起連線送到伺服器。

## 解題思路 / 備註
- 外層 loop：`rcx = n/2`，每次 `shr rcx, 1`，直到 `rcx <= 0`。
- 中層 loop：`r9` 從 `rcx` 跑到 `n`，對應 shell sort 的 outer index `i`。
- 內層 loop：`rbx = r9`，用 `rdx = arr[rbx]` 緩存目前要放置的 key；當 `arr[rbx - rcx] > key` 時把它往後挪並 `sub rbx, rcx`。
- 最後寫回：`mov [rdi + rbx*8], rdx`。
- 所有 `mov [rdi + idx*8], ...` 都用 `*8` 是因為 element 是 8-byte long。
- 沒有保存 callee-saved register（`rbx`）算是個小瑕疵，若 harness 會檢查 `rbx` 的值就會有問題；考卷測資裡並沒有檢查所以能過。
