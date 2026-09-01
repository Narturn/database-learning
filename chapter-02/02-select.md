# Chapter 2.2 — Select

## Select là gì?

SELECT dùng để truy vấn và trả về dữ liệu từ database

Ví dụ:

```SQL
SELECT *
FROM shop_players;
```

Nếu table:

```
id | username | level | gold
---|----------|-------|-----
1  | yasuo    | 10    | 500
2  | yone     | 5     | 200
3  | faker    | 20    | 1000
```

thì SELECT trả về các row đó.

### Select *

```SQL
SELECT *
FROM shop_players;
```

`*` nghĩa là:

lấy tất cả column.

```
*
↓
id
username
level
gold
```

⚠️ SELECT * rất tiện lúc học/debug.

Nhưng khi viết application thực tế, không nên lạm dụng.

Nếu table có:

```
id
username
email
password_hash
avatar
created_at
...
```

mà API chỉ cần:

```
id
username
```

thì không cần lấy toàn bộ.

### Chọn column cụ thể

```SQL
SELECT username, level
FROM shop_players;
```

Kết quả:

username | level
---------|------
yasuo    | 10
yone     | 5
faker    | 20

Tức là:

```
SELECT
    ↓
tao muốn lấy cái gì?

FROM
    ↓
lấy từ table nào?
```

Đây là cấu trúc cơ bản:

```SQL
SELECT column1, column2
FROM table_name;
```

Thứ tự viết câu SELECT:

```SQL
SELECT ...
FROM ...
WHERE ...
ORDER BY ...
```

### Đặt alias cho column

Có thể đổi tên column trong kết quả bằng alias:

```SQL
SELECT
    username AS player_name,
    level AS player_level
FROM shop_players;
```

Kết quả:

player_name | player_level
------------|-------------
yasuo       | 10
yone        | 5
faker       | 20

⚠️ Alias không đổi tên column trong database.

Database vẫn là:

```
username
level
```

Chỉ kết quả SELECT được gọi là:

```
player_name
player_level
```

Có thể bỏ AS:

```SQL
SELECT
    username player_name,
    level player_level
FROM shop_players;
```

### SELECT có thể tính toán

SQL không chỉ lấy nguyên column mà còn có thể tính toán.

Ví dụ:

```
SELECT
    username,
    level,
    gold + 100 AS gold_after_bonus
FROM shop_players;
```

Nếu:

```
yasuo | 10 | 500
```

thì kết quả:

```
yasuo | 10 | 600
```

⚠️ Nhưng database không sửa gold.

Nó chỉ tính giá trị trong kết quả SELECT.

Database vẫn:

gold = 500

Đây là distinction quan trọng:

```
SELECT expression
→ tính dữ liệu để trả về

UPDATE
→ thực sự thay đổi dữ liệu
```

### Có thể dùng expression

Ví dụ:

```SQL
SELECT
    username,
    level * 10 AS power
FROM shop_players;
```

Database tính:

```
yasuo → level 10 → power 100
yone  → level 5  → power 50
faker → level 20 → power 200
```

Nhưng không có column power được tạo ra.

Nó chỉ tồn tại trong result set.

### SELECT DISTINCT

Nếu muốn loại bỏ các giá trị trùng:

```SQL
SELECT DISTINCT level
FROM shop_players;
```

Ví dụ:

level |
----- |
10    |
5     |
20    |

Nếu dữ liệu:

```
yasuo  → 10
yone   → 5
faker  → 20
playerX → 10
```

thì:

```SQL
SELECT level
FROM shop_players;
```

cho:

```
10
5
20
10
```

còn:

```SQL
SELECT DISTINCT level
FROM shop_players;
```

cho:

```
10
5
20
```

DISTINCT áp dụng lên toàn bộ tập column được SELECT.

Ví dụ:

```SQL
SELECT DISTINCT level, gold
FROM shop_players;
```

thì SQL Server xét cặp (level, gold), chứ không loại duplicate từng column riêng lẻ.

### SELECT không có FROM

SQL Server còn cho phép:

```SQL
SELECT 1;
```

hoặc:

```SQL
SELECT 10 + 20;
```

Kết quả:

```
30
```

Điều này khá hữu ích để hiểu rằng:

    SELECT không nhất thiết lúc nào cũng phải đọc một table.

Nhưng trong application thì phần lớn SELECT của mày sẽ lấy dữ liệu từ table.

## Tổng hợp cú pháp:

| Mục đích | Syntax |
|---|---|
| Lấy tất cả column | `SELECT * FROM table;` |
| Lấy column cụ thể | `SELECT column1, column2 FROM table;` |
| Alias | `SELECT column AS alias FROM table;` |
| Tính toán | `SELECT column1 + value AS alias FROM table;` |
| DISTINCT | `SELECT DISTINCT column FROM table;` |