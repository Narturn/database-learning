# Chapter 3.2 — INNER JOIN.

## INNER JOIN là gì?

`INNER JOIN` dùng để kết hợp dữ liệu từ nhiều table dựa trên một điều kiện liên kết.

Ta đang có:

`shop_players`

```
id   username
1    yasuo
2    Bliat
3    d
10   yone
11   faker
15   Ex5
17   ex_order
```

`shop_orders`

id |  player_id | item    | price
---|------------|---------|-------
1  |  1         |  Sword  |  500
2  |  1         |  Armor  |  800
3  |  2         |  Potion |  100

Muốn lấy:

```
username | item | price
```

thì cần ghép:

```
shop_orders.player_id
        =
shop_players.id
```

## Cú pháp cơ bản

```SQL
SELECT columns
FROM table1
INNER JOIN table2
    ON table1.column = table2.column;
```

Ví dụ:

```SQL
SELECT
    shop_players.username,
    shop_orders.item,
    shop_orders.price
FROM shop_players
INNER JOIN shop_orders
    ON shop_players.id = shop_orders.player_id;
```

Kết quả:

username |  item    |  price
---------|----------|---------
yasuo    |  Sword   |   500
yasuo    |  Armor   |   800
Bliat    |  Potion  |   100

### ON làm nhiệm vụ gì?

Đây là phần quan trọng nhất:

```SQL
ON shop_players.id = shop_orders.player_id
```

Nó nói với SQL Server:

`"Ghép những row nào mà shop_players.id bằng shop_orders.player_id."`

Ví dụ:

```
shop_players.id = 1
        ↓
shop_orders.player_id = 1
        ↓
        MATCH
```

Nên:

```
yasuo → Sword
yasuo → Armor
```

Còn:

```
shop_players.id = 3
```

không có order nào:

```
shop_orders.player_id = 3
```

→ không xuất hiện trong kết quả `INNER JOIN`.

## INNER JOIN chỉ lấy những row có match

Đây chính là đặc điểm cốt lõi.

```
shop_players              shop_orders

1 yasuo      ←──────────→ 1 Sword
             ←──────────→ 1 Armor

2 Bliat      ←──────────→ 2 Potion

3 d          ←────── X ──  không có order
10 yone      ←────── X ──  không có order
11 faker     ←────── X ──  không có order
```

Kết quả:

```
yasuo   Sword
yasuo   Armor
Bliat   Potion
```

`d`, `yone`, `faker`... bị loại vì không có row tương ứng ở `shop_orders`.

## Dùng alias

Viết:

```SQL
shop_players.username
```

và:

```SQL
shop_orders.player_id
```

nhiều lần khá dài.

Có thể đặt alias:

```SQL
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
INNER JOIN shop_orders AS o
    ON p.id = o.player_id;
```

Hoặc bỏ AS:

```SQL
FROM shop_players p
INNER JOIN shop_orders o
    ON p.id = o.player_id;
```

Hai cách này tương đương.

Alias chỉ tồn tại trong query đó.

## Có thể thêm WHERE

JOIN và WHERE làm hai nhiệm vụ khác nhau.

Ví dụ:

```SQL
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players p
INNER JOIN shop_orders o
    ON p.id = o.player_id
WHERE o.price >= 500;
```

Hiểu đơn giản:

```
JOIN
↓
ghép player với order

WHERE
↓
chỉ giữ order có price >= 500
```

Kết quả:

```
yasuo   Sword    500
yasuo   Armor    800
```

`Potion = 100` bị WHERE loại.

## JOIN không làm thay đổi dữ liệu

Câu:

```SQL
SELECT ...
FROM ...
INNER JOIN ...
```

chỉ tạo ra result set.

Nó không:

- thêm row
- sửa row
- xóa row
- thay đổi table

Giống `SELECT` mà mày học trước đó.

## INNER JOIN không bắt buộc phải có Foreign Key

Điểm này mày đã ghi ở bài trước.

Ví dụ:

```SQL
FROM A
INNER JOIN B
    ON A.some_id = B.some_id
```

SQL Server vẫn JOIN được ngay cả khi hai column đó không khai báo FK.

FK giúp database bảo vệ relationship.

JOIN chỉ cần có điều kiện để ghép dữ liệu.

## Hãy nhìn JOIN như việc ghép từng row

Đây là cách hiểu thay vì học thuộc hình Venn diagram.

Ta có:

```
players
id = 1, username = yasuo
```

và:

```
orders
player_id = 1, item = Sword
```

Điều kiện:

```SQL
p.id = o.player_id
```

-> match.

Sau đó order thứ hai:

```
player_id = 1, item = Armor
```

cũng match.

Nên một player có nhiều order sẽ tạo ra nhiều row trong kết quả JOIN.

Đây là lý do:

```
yasuo
```

xuất hiện hai lần.

Không phải SQL bị lỗi. Nó đang làm đúng việc mày bảo nó làm.

## Tổng hợp cú pháp

| Mục đích        | Cú pháp                                |
| --------------- | -------------------------------------- |
| INNER JOIN      | `FROM A INNER JOIN B ON A.id = B.a_id` |
| Alias           | `FROM A AS a`                          |
| JOIN bằng alias | `ON a.id = b.a_id`                     |
| JOIN + WHERE    | `... JOIN B ... WHERE condition`       |
