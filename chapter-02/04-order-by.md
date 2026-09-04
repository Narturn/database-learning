# Chapter 2.4 — Order by

## Order by là gì?

ORDER BY dùng để sắp xếp các dòng trong kết quả của SELECT.

Ví dụ bảng:

```
shop_players

id   username   level   gold
1    yasuo      10      500
2    yone       5       100
3    faker      20      1000
4    d           1       50
```

Nếu:

```SQL
SELECT *
FROM shop_players
ORDER BY level;
```

Kết quả:

```
d       1
yone    5
yasuo   10
faker   20
```

Mặc định là tăng dần.

### ASC và DESC

Có hai kiểu sắp xếp:

`ASC` = Ascending

Tăng dần:

```SQL
SELECT *
FROM shop_players
ORDER BY level ASC;
1
5
10
20
```

`ASC` là mặc định nên viết:

```SQL
ORDER BY level;
```

hay:

```SQL
ORDER BY level ASC;
```

về cơ bản giống nhau.

---

`DESC` = Descending

Giảm dần:

```SQL
SELECT *
FROM shop_players
ORDER BY level DESC;
20
10
5
1
```

Đây là cái sẽ dùng rất nhiều.

Ví dụ:

```SQL
-- Player level cao nhất trước
SELECT username, level
FROM shop_players
ORDER BY level DESC;
```

### Order by không chỉ sắp xếp theo số

Theo chuỗi:

```SQL
SELECT username
FROM shop_players
ORDER BY username ASC;
```

Ví dụ:

```
d
faker
yasuo
yone
```

Với chuỗi, SQL Server sắp xếp dựa trên quy tắc so sánh của collation.

**ORDER BY có thể sắp xếp cả số, chuỗi, ngày tháng,...**

### Sắp xếp theo nhiều cột

Ví dụ:

```SQL
SELECT username, level, gold
FROM shop_players
ORDER BY level DESC, gold DESC;
```

SQL sẽ:

1. Sắp xếp level giảm dần.
2. Nếu hai người có cùng level, mới xét gold.
3. gold cũng giảm dần.

Ví dụ:

```
username   level   gold
faker      20      1000
yasuo      10      500
yone       10      300
d           1       50
```

Hai người level = 10:

```
yasuo  500
yone   300
```

nên gold DESC quyết định thứ tự giữa hai người đó.

```SQL
ORDER BY level DESC, gold DESC
```

Nó có nghĩa:

```
"Ưu tiên level, rồi dùng gold để phá hòa."
```

### Có thể ORDER BY cột không SELECT không?

**Có.**

Ví dụ:

```SQL
SELECT username
FROM shop_players
ORDER BY level DESC;
```

Kết quả chỉ hiển thị:

```
faker
yasuo
yone
d
```

Nhưng SQL vẫn dùng level để quyết định thứ tự.

Đây là thứ rất hay gặp.

### ORDER BY với expression

Có thể sắp xếp bằng một biểu thức.

Ví dụ:

```SQL
SELECT
    username,
    gold,
    gold + 100 AS bonus_gold
FROM shop_players
ORDER BY gold + 100 DESC;
```

SQL tính:

gold + 100

rồi dùng kết quả đó để sắp xếp.

Nhưng nếu đã đặt `alias` thì dùng:

```SQL
SELECT
    username,
    gold + 100 AS bonus_gold
FROM shop_players
ORDER BY bonus_gold DESC;
```

Cách này rất tiện.

bonus_gold chỉ là alias của kết quả trong query, không phải một column thật trong database.

### Thứ tự cơ bản của query

Mày sẽ bắt đầu gặp cấu trúc:

```SQL
SELECT ...
FROM ...
WHERE ...
ORDER BY ...;
```

Ví dụ:

```SQL
SELECT username, level, gold
FROM shop_players
WHERE level >= 5
ORDER BY gold DESC;
```

Hiểu đơn giản:

```
FROM
 ↓
WHERE
 ↓
SELECT
 ↓
ORDER BY
 ↓
Kết quả
```

Tức là:

Lấy bảng → lọc những player level >= 5 → lấy các cột cần thiết → sắp xếp theo gold giảm dần.

Đừng học thuộc thứ tự thực thi quá sâu. Chỉ cần biết WHERE lọc trước khi kết quả được ORDER BY.

## Tổng hợp cú pháp

| Cú pháp                               | Ý nghĩa                 |
| ------------------------------------- | ----------------------- |
| `ORDER BY column;`                    | Tăng dần                |
| `ORDER BY column ASC;`                | Tăng dần                |
| `ORDER BY column DESC;`               | Giảm dần                |
| `ORDER BY column1, column2;`          | Nhiều cột               |
| `ORDER BY column1 DESC, column2 ASC;` | Mỗi cột một hướng       |
| `ORDER BY expression DESC;`           | Sắp xếp bằng expression |
| `ORDER BY alias DESC;`                | Sắp xếp bằng alias      |
