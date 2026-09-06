# Chapter 3.3 - LEFT JOIN & RIGHT JOIN

## LEFT JOIN là gì?

`LEFT JOIN` giữ tất cả rows của table bên trái, kể cả khi không có row tương ứng ở table bên phải.

Vẫn dùng:

```
shop_players
shop_orders
```

Ta có:

```
shop_players

1  yasuo
2  Bliat
3  d
10 yone
11 faker
15 Ex5
17 ex_order
```

và:

```
shop_orders

1  → player_id 1 → Sword
2  → player_id 1 → Armor
3  → player_id 2 → Potion
```

Query:

```SQL
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
LEFT JOIN shop_orders AS o
    ON p.id = o.player_id;
```

Kết quả sẽ có cả:

```
yasuo      Sword
yasuo      Armor
Bliat      Potion
d          NULL
yone       NULL
faker      NULL
Ex5        NULL
ex_order   NULL
```

**Tại sao những player không có order vẫn xuất hiện?**

Đây chính là điểm khác `INNER JOIN`.

Với:

```SQL
INNER JOIN
```

SQL chỉ giữ row có match.

Còn:

```SQL
LEFT JOIN
```

SQL nói:

`"Tao muốn giữ toàn bộ table bên trái."`

Ở đây:

```SQL
FROM shop_players AS p
LEFT JOIN shop_orders AS o
```

`shop_players` là LEFT table.

Vì vậy:

```
shop_players
↓
GIỮ TẤT CẢ
```

Còn nếu không tìm được order:

```
o.item
o.price
```

sẽ trở thành:

`NULL`

## LEFT JOIN nhìn theo từng row

Ví dụ:

```
p.id = 3
p.username = d
```

SQL tìm:

```
o.player_id = 3
```

Không có.

Với INNER JOIN:

```
d → ❌ bị loại
```

Với LEFT JOIN:

```
d → NULL
```

Tức là row của `d` vẫn tồn tại trong kết quả.

## LEFT JOIN rất hữu ích khi tìm dữ liệu "chưa có"

Ví dụ:

`Tìm tất cả player chưa mua item nào.`

Có thể dùng:

```SQL
SELECT
    p.username
FROM shop_players AS p
LEFT JOIN shop_orders AS o
    ON p.id = o.player_id
WHERE o.id IS NULL;
```

Kết quả:

```
d
yone
faker
Ex5
ex_order
```

Logic:

```
LEFT JOIN
↓
giữ tất cả player

player không có order
↓
các column của order = NULL

WHERE o.id IS NULL
↓
chỉ lấy những player đó
```

Đây là pattern cực kỳ thực tế.

## LEFT JOIN + WHERE có một cái bẫy

So sánh:

```SQL
SELECT *
FROM shop_players p
LEFT JOIN shop_orders o
    ON p.id = o.player_id
WHERE o.price >= 500;
```

Ở đây những player không có order có:

```
o.price = NULL
```

Mà:

```
NULL >= 500
```

không phải `TRUE`.

Vì vậy query này có thể khiến kết quả trông giống INNER JOIN đối với điều kiện đó.

Đây là một lỗi rất hay gặp khi mới học JOIN.

Chưa cần đào sâu hơn ở bài này, chỉ cần nhớ:

**Với `LEFT JOIN`, điều kiện đặt ở `ON` và `WHERE` có thể tạo ra kết quả khác nhau.**

## RIGHT JOIN là gì?

`RIGHT JOIN` ngược lại:

*Giữ tất cả rows của table bên phải.*

Ví dụ:

```SQL
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
RIGHT JOIN shop_orders AS o
    ON p.id = o.player_id;
```

Ở đây:

```
shop_orders
```

là RIGHT table.

Vì vậy tất cả orders được giữ lại.

## LEFT JOIN và RIGHT JOIN thực chất giống nhau

Hai query này về bản chất có thể cho cùng kết quả:

```SQL
FROM shop_players p
LEFT JOIN shop_orders o
    ON p.id = o.player_id
```

và:

```SQL
FROM shop_orders o
RIGHT JOIN shop_players p
    ON p.id = o.player_id
```

Chỉ là đổi vị trí hai table.

Vì vậy trong code thực tế người ta thường ưu tiên LEFT JOIN, vì dễ đọc hơn khi giữ table chính ở bên trái.

## Nội dung cần nhớ

| JOIN         | Rows được giữ                              |
| ------------ | ------------------------------------------ |
| `INNER JOIN` | Chỉ rows có match                          |
| `LEFT JOIN`  | Tất cả rows bên trái + rows match bên phải |
| `RIGHT JOIN` | Tất cả rows bên phải + rows match bên trái |

Với:

```
players = 7 rows
orders = 3 rows
```

`INNER JOIN`:

```
3 rows
```

vì hiện tại mỗi order đều có player hợp lệ.

`LEFT JOIN` từ players:

```
7 rows
```

vì giữ toàn bộ players.

**Cú pháp**

| Mục đích               | Cú pháp                                |
| ---------------------- | -------------------------------------- |
| LEFT JOIN              | `FROM A LEFT JOIN B ON A.id = B.a_id`  |
| RIGHT JOIN             | `FROM A RIGHT JOIN B ON A.id = B.a_id` |
| Tìm row không có match | `LEFT JOIN ... WHERE B.id IS NULL`     |
| LEFT JOIN + filter     | `LEFT JOIN ... ON ... WHERE condition` |
