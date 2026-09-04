# Chapter 2.6 — Aggregate Function

## Aggregate Function là gì?

Aggregate function là hàm thực hiện tính toán trên nhiều dòng và trả về một giá trị tổng hợp.

Ví dụ bảng:

```
shop_players

username   level   gold
yasuo      10      500
Bliat       1        0
d           1        5
yone        5      200
faker      20     1000
```

Muốn biết tổng gold:

```SQL
SELECT SUM(gold)
FROM shop_players;
```

Kết quả có thể là:

```
1705
```

Nó không trả về 7 dòng.

Nó gom dữ liệu lại và trả về một kết quả.

## Những Aggregate Functions quan trọng

Ở bài này chỉ cần tập trung vào 5 hàm chính:

| Function  | Ý nghĩa    |
| --------- | ---------- |
| `COUNT()` | Đếm        |
| `SUM()`   | Tổng       |
| `AVG()`   | Trung bình |
| `MIN()`   | Nhỏ nhất   |
| `MAX()`   | Lớn nhất   |

### 1. `COUNT()`

Đếm số dòng:

```SQL
SELECT COUNT(*)
FROM shop_players;
```

Nếu có 8 player:

```
8
```

`COUNT(*)`

Có nghĩa:

*Đếm tất cả các dòng.*

`COUNT(column)`

Ví dụ:

```SQL
SELECT COUNT(gold)
FROM shop_players;
```

Nó đếm số dòng mà `gold` không phải `NULL`.

Đây là khác biệt quan trọng:

```
COUNT(*)       → đếm dòng
COUNT(column)  → đếm giá trị khác NULL của column
```

Ví dụ:

```
username   gold
yasuo      500
yone       200
faker      NULL
```
```SQL
COUNT(*)
```

-> 3

```SQL
COUNT(gold)
```

-> 2

### 2. `SUM()`

Tính tổng:

```SQL
SELECT SUM(gold)
FROM shop_players;
```

Ví dụ:

```
500 + 0 + 5 + 200 + 1000 = 1705
```

Kết quả:

```
1705
```

`SUM()` bỏ qua `NULL`.

Ví dụ:

```
500
NULL
200
```

thì:

```SQL
SUM(gold)
```

-> 700.

### 3. `AVG()`

Tính trung bình:

```SQL
SELECT AVG(level)
FROM shop_players;
```

Ví dụ:

```
10 + 1 + 1 + 5 + 20
--------------------
         5
```

SQL Server sẽ trả về giá trị trung bình dựa trên các giá trị không phải `NULL`.

⚠️ Có một điểm dễ dính bug:

Nếu column là `INT`, việc tính `AVG()` trong SQL Server có kiểu dữ liệu và quy tắc riêng, nên đừng tự nghĩ rằng kết quả lúc nào cũng là một `INT` bị cắt phần thập phân.

Ví dụ tốt nhất là cứ chạy:

```SQL
SELECT AVG(CAST(level AS DECIMAL(10,2)))
FROM shop_players;
```

khi mày muốn chủ động kiểm soát kiểu kết quả.

### 4. `MIN()`

Lấy giá trị nhỏ nhất:

```SQL
SELECT MIN(level)
FROM shop_players;
```

Ví dụ:

-> 1

Hoặc:

```SQL
SELECT MIN(gold)
FROM shop_players;
```

-> 0

### 5. `MAX()`

Lấy giá trị lớn nhất:

```SQL
SELECT MAX(level)
FROM shop_players;
```

-> 20

Hoặc:

```SQL
SELECT MAX(gold)
FROM shop_players;
```

-> `6000` 

"Tau tính cho thằng `ex_order` 600 vàng mà thừa số 0 nên thằng `ex_order` giàu vcl. Thôi kệ như vậy luôn, cho nó làm Phạm Nhật Vượng"

## Có thể dùng nhiều aggregate function cùng lúc

Ví dụ:

```SQL
SELECT
    COUNT(*) AS player_count,
    SUM(gold) AS total_gold,
    AVG(level) AS average_level,
    MIN(level) AS min_level,
    MAX(level) AS max_level
FROM shop_players;
```

Kết quả sẽ là một dòng:

player_count | total_gold | average_level | min_level | max_level
-------------|------------|---------------|-----------|----------
8            | ...        | ...           | 1         | 20

Đây là một pattern cực kỳ phổ biến trong thực tế.

## Aggregate Function + `WHERE`

Đây là phần rất quan trọng.

Ví dụ:

*Tổng gold của những player level >= 10.*

```SQL
SELECT SUM(gold)
FROM shop_players
WHERE level >= 10;
```

Logic:

```
FROM
 ↓
WHERE
 ↓
Aggregate
 ↓
Kết quả
```

Tức là:

*Lọc player trước -> sau đó tính tổng trên những player còn lại.*

Tương tự:

```SQL
SELECT MAX(gold)
FROM shop_players
WHERE level >= 10;
```

-> player level >= 10 có bao nhiêu gold cao nhất.

## Tổng hợp cú pháp

| Cú pháp                       | Ý nghĩa                 |
| ----------------------------- | ----------------------- |
| `COUNT(*)`                    | Đếm số dòng             |
| `COUNT(column)`               | Đếm giá trị khác `NULL` |
| `SUM(column)`                 | Tính tổng               |
| `AVG(column)`                 | Tính trung bình         |
| `MIN(column)`                 | Giá trị nhỏ nhất        |
| `MAX(column)`                 | Giá trị lớn nhất        |
| `SUM(column) WHERE condition` | Tổng sau khi lọc        |
| `MAX(column) WHERE condition` | Max sau khi lọc         |
