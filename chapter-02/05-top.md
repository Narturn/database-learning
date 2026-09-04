# Chapter 2.5 — Top

## Top là gì?

Ví dụ bảng hiện tại của mày:

```
shop_players

id   username   level   gold
1    yasuo      10      500
2    Bliat       1        0
3    d           1        5
10   yone        5      200
11   faker      20     1000
12   player_x    1        0
15   Ex5         10     500
```

Muốn lấy 3 dòng đầu tiên:

```SQL
SELECT TOP 3 *
FROM shop_players;
```

SQL Server chỉ trả về 3 dòng.

⚠️ Nhưng có một vấn đề:

**"3 dòng đầu tiên" theo thứ tự nào?**

vì vậy ta cần **TOP + ORDER BY**

### TOP + ORDER BY

Đây mới là cách dùng cực kỳ quan trọng.

Muốn lấy 3 player có level cao nhất:

```SQL
SELECT TOP 3 username, level
FROM shop_players
ORDER BY level DESC;
```

Logic:

```
FROM
 ↓
WHERE
 ↓
ORDER BY
 ↓
TOP
 ↓
kết quả
```

Kết quả hiện tại:

```
faker    20
yasuo    10
Ex5      10
```

### TOP với phần trăm

SQL Server còn có:

```SQL
SELECT TOP 50 PERCENT *
FROM shop_players;
```

Nó lấy khoảng 50% số dòng.

Ví dụ 8 dòng thì khoảng 4 dòng.

### TOP với biến

Có thể viết:

```
DECLARE @n INT = 3;

SELECT TOP (@n) *
FROM shop_players
ORDER BY level DESC;
```

Ở đây:

```
@n = 3
```

nên lấy 3 dòng.

Cái này sau này sẽ hữu ích khi làm query động.

Hiện tại chỉ cần biết tồn tại, chưa cần đào sâu.

### TOP khác WHERE

Đây là điểm cần hiểu.

WHERE:

*Lọc dựa trên điều kiện.*

Ví dụ:

```SQL
SELECT *
FROM shop_players
WHERE level >= 10;
```

Lấy tất cả player có level >= 10.

TOP:

*Giới hạn số dòng.*

```SQL
SELECT TOP 3 *
FROM shop_players;
```

Chỉ lấy tối đa 3 dòng.

Có thể kết hợp:

```SQL
SELECT TOP 3 username, level, gold
FROM shop_players
WHERE level >= 5
ORDER BY gold DESC;
```

Nghĩa là:

Trong những player level >= 5, lấy 3 người có gold cao nhất.

### TOP và ORDER BY phải đi cùng nhau trong nhiều trường hợp

Ví dụ mày muốn:

*5 player giàu nhất.*

Viết:

```SQL
SELECT TOP 5 username, gold
FROM shop_players
ORDER BY gold DESC;
```

Nếu bỏ:

```SQL
ORDER BY gold DESC
```

thì mày không còn đảm bảo đó là 5 người giàu nhất.

Mày chỉ đang nói:

*"Đưa tao 5 dòng nào đó."*

### TOP ... WITH TIES

Có một thứ đáng biết, nhưng chưa cần học sâu:

```SQL
SELECT TOP 3 WITH TIES username, level
FROM shop_players
ORDER BY level DESC;
```

WITH TIES cho phép lấy thêm những dòng bằng giá trị ORDER BY của dòng cuối cùng.

Ví dụ:

```
faker    20
yasuo    10
Ex5      10
yone      5
```

TOP 2 bình thường:

```
faker
yasuo
```

Nhưng:

```SQL
TOP 2 WITH TIES
```

có thể trả:

```
faker
yasuo
Ex5
```

vì yasuo và Ex5 cùng level = 10.

## Tổng hợp cú pháp

| Cú pháp                         | Ý nghĩa                            |
| ------------------------------- | ---------------------------------- |
| `SELECT TOP n ...`              | Lấy tối đa `n` dòng                |
| `SELECT TOP n ... ORDER BY ...` | Lấy `n` dòng theo thứ tự xác định  |
| `SELECT TOP n PERCENT ...`      | Lấy khoảng `n%` số dòng            |
| `SELECT TOP n WITH TIES ...`    | Có thể lấy thêm dòng bị hòa ở cuối |
| `SELECT TOP (@n) ...`           | Số dòng lấy từ biến                |
