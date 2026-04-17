# Lab 1 — Proof-of-Work 與四則運算挑戰

## 題目描述
透過 `pwntools` 連線到課程的挑戰伺服器 `up23.zoolab.org:10363`，在限定時間內完成以下兩個階段：

1. **Proof-of-Work (PoW)**：伺服器會給一段前綴字串 `prefix`，需要找到一個數字 `i` 使得 `sha1(prefix + str(i))` 的 hex 前 6 碼為 `000000`，再把 `i` 用 base64 編碼後回傳。
2. **計算挑戰**：伺服器連續送來 `N` 題形如 `a + b * c = ?` 的整數四則運算，每一題的答案必須轉成 little-endian byte string 後再 base64 編碼回傳。

主要在練習：Python + pwntools 的 socket IO、雜湊運算、以及資料格式轉換 (int ↔ little-endian bytes ↔ base64)。

## 檔案說明
| 檔案 | 說明 |
| --- | --- |
| `pow.py` | 課程提供的 PoW 範本 (SHA1 爆破 + base64) |
| `solve.py` | 我的主要解題程式，包含 PoW 與四則運算挑戰的處理 |
| `test.py` | 用來測試 pwntools `process` + `shell` 的小片段 |
| `lab1.zip` | 課程提供的原始題目壓縮檔 |

## 執行方式
```bash
pip install pwntools
./solve.py
```

需要連線到 `up23.zoolab.org:10363`，本機測試時可改用註解中的 `r = remote('localhost', 10330)`。

## 解題思路 / 備註
- PoW 直接從 `0` 開始 brute-force，`sha1` 前 6 hex chars = `000000` 大約 1/16^6 機率，一般幾秒內可以解出。
- 整數轉 byte string 時要用 `num.to_bytes((num.bit_length()+7)//8, 'little')`，`bit_length` 取 ceil 才能同時處理正整數與 0。
- 運算式直接用 `eval(eq)` 偷懶解析，因為題目保證格式合法。
- Timeout 處理：迴圈外包 `try/except`，任何解析/傳輸錯誤就直接中斷並進入 `interactive()`。
