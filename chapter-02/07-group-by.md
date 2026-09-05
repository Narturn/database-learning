# Chapter 2.7 — GROUP BY

## `GROUP BY` là gì?

Nhắc lại:

```SQL
SELECT COUNT(*)
FROM shop_players;
```

-> đếm toàn bộ player.

Nhưng giả sử tao muốn:

`Có bao nhiêu player ở mỗi level?`

Ta có:

```SQL
SELECT level, COUNT(*) AS player_count
FROM shop_players
GROUP BY level;
```

Kết quả có thể:

level |  player_count
----- |  ------------
1     |  3
5     |  1
10    |  3
20    |  1

Ở đây:

```
GROUP BY level
```

chia dữ liệu thành các nhóm:

```
level = 1
level = 5
level = 10
level = 20
```

Sau đó:

```
COUNT(*)
```

được tính riêng trong từng nhóm.

## So sánh Aggregate bình thường với `GROUP BY`

Không có GROUP BY:

```SQL
SELECT COUNT(*)
FROM shop_players;
```

-> một kết quả:

`8`

Có GROUP BY:

```SQL
SELECT level, COUNT(*)
FROM shop_players
GROUP BY level;
```

-> một kết quả cho mỗi nhóm level.

Đây là ý tưởng cốt lõi:

```
Aggregate
    ↓
Toàn bộ dữ liệu
    ↓
một kết quả

GROUP BY + Aggregate
    ↓
Chia thành các nhóm
    ↓
mỗi nhóm một kết quả
```

## GROUP BY không chỉ dùng với `COUNT()`

Có thể dùng toàn bộ Aggregate Function đã học.

`SUM()`

Ví dụ:

Tổng gold của player ở từng level.

```SQL
SELECT
    level,
    SUM(gold) AS total_gold
FROM shop_players
GROUP BY level;
```

Ví dụ:

level  | total_gold
-----  | ----------
1      | 5
5      | 200
10     | 7000
20     | 1000

`AVG()`

```SQL
SELECT
    level,
    AVG(gold) AS average_gold
FROM shop_players
GROUP BY level;
```

-> Gold trung bình của từng level.

`MIN()` / `MAX()`

```SQL
SELECT
    level,
    MIN(gold) AS min_gold,
    MAX(gold) AS max_gold
FROM shop_players
GROUP BY level;
```

## Có thể GROUP BY nhiều cột

Ví dụ:

```SQL
SELECT
    level,
    gold,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level, gold;
```

Khi đó nhóm được xác định bởi cả `level` và `gold`.

`level = 10` nhưng gold khác nhau -> hai nhóm khác nhau.

Tư duy:

```SQL
GROUP BY level, gold
```

`"Những dòng có cùng level và cùng gold vào chung một nhóm."`

## Quy tắc cực kỳ quan trọng

Khi dùng `GROUP BY`, những column xuất hiện trong `SELECT` mà không nằm trong Aggregate Function thường phải xuất hiện trong `GROUP BY`.

Ví dụ:

```SQL
SELECT
    level,
    username,
    COUNT(*)
FROM shop_players
GROUP BY level;
```

❌ Sai.

Nhưng:

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level;
```

`level`

có trong `GROUP BY`.

✅ Đúng.

Tại sao?

Giả sử:

```
level = 10
```

có:

```
yasuo
Ex5
ex_order
```

SQL sẽ phải trả lời:

`"Vậy trong group level 10, username là thằng nào?"`

Có 3 giá trị.

Database không thể tự chọn một cách hợp lệ.

## `GROUP BY` + `WHERE`

Đây là pattern rất quan trọng.

Ví dụ:

`Đếm số player có level từ 5 trở lên, chia theo từng level.`

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
WHERE level >= 5
GROUP BY level;
```

Tư duy:

```
FROM
 ↓
WHERE
 ↓
GROUP BY
 ↓
Aggregate
 ↓
Kết quả
```

Tức là:

`Lọc trước → chia nhóm → tính toán từng nhóm.`

## `GROUP BY` + `ORDER BY`

Ví dụ:

`Level nào có nhiều player nhất?`

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level
ORDER BY player_count DESC;
```

Kết quả kiểu:

level |  player_count
----- |  ------------
10    |  3
1     |  3
5     |  1
20    |  1

Ở đây `ORDER BY` đang sắp xếp kết quả đã được `GROUP BY`.

### Ví dụ thực tế

`Tổng gold theo từng level, level nào có tổng gold cao nhất đứng đầu.`

```SQL
SELECT
    level,
    SUM(gold) AS total_gold
FROM shop_players
GROUP BY level
ORDER BY total_gold DESC;
```

Nếu dữ liệu hiện tại của mày có:

```
level = 10
```

với:

```
500 + 500 + 6000
```

thì:

```
total_gold = 7000
```

Database trả về thống kê theo từng nhóm.

Đây là pattern rất hay gặp trong:

- leaderboard
- dashboard
- reporting
- analytics
- thống kê game
- thống kê đơn hàng

## `GROUP BY` không làm thay đổi dữ liệu

Giống `SELECT`, nó chỉ tạo result set.

```SQL
SELECT
    level,
    COUNT(*)
FROM shop_players
GROUP BY level;
```

không sửa bảng `shop_players`.

Không insert.

Không update.

Không delete.

Chỉ truy vấn và tổng hợp dữ liệu.

## Tổng hợp cú pháp

| Cú pháp                      | Ý nghĩa                      |
| ---------------------------- | ---------------------------- |
| `GROUP BY column`            | Chia dữ liệu theo một column |
| `GROUP BY column1, column2`  | Chia theo nhiều column       |
| `GROUP BY column + COUNT(*)` | Đếm từng nhóm                |
| `GROUP BY column + SUM(...)` | Tính tổng từng nhóm          |
| `WHERE ... GROUP BY ...`     | Lọc trước rồi nhóm           |
| `GROUP BY ... ORDER BY ...`  | Nhóm rồi sắp xếp kết quả     |
