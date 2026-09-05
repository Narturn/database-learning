# Chapter 3.1 — Foreign Key & Relationships

Bài này phải học trước khi vào JOIN. Nếu không thì JOIN chỉ thành trò ghép bảng bằng niềm tin, mà SQL thì không vận hành bằng niềm tin.

## Tại sao cần Relationship?

Giả sử game có:

`shop_players`

| id | username |
| -: | -------- |
|  1 | yasuo    |
|  2 | Bliat    |
|  3 | d        |

`shop_orders`

| id | player_id | item   | price |
| -: | --------: | ------ | ----: |
|  1 |         1 | Sword  |   500 |
|  2 |         1 | Armor  |   800 |
|  3 |         2 | Potion |   100 |

Nhìn vào:

```
shop_orders.player_id
        ↓
shop_players.id
```

Ta biết:

```
Order 1 → yasuo
Order 2 → yasuo
Order 3 → Bliat
```

Đây chính là relationship giữa hai table.

## Foreign Key là gì?

`Foreign Key (FK)` là một column dùng để tham chiếu đến một row ở table khác.

Ví dụ:

```SQL
CREATE TABLE shop_orders (
    id INT PRIMARY KEY,
    player_id INT,
    item VARCHAR(50),
    price INT,

    FOREIGN KEY (player_id)
        REFERENCES shop_players(id)
);
```

Ở đây:

```
shop_orders.player_id
        ↓
shop_players.id
```

## FK giúp bảo vệ dữ liệu

Giả sử `shop_players` chỉ có:

```
id
1
2
3
```

Mày thử:

```SQL
INSERT INTO shop_orders
    (id, player_id, item, price)
VALUES
    (4, 999, 'Sword', 500);
```

❌ Nếu `player_id` có FK `tới shop_players(id)`, SQL Server sẽ từ chối.

Tại sao?

Vì:

```
player_id = 999
```

nhưng player `999` không tồn tại.

Database không cho phép tạo một order trỏ tới một player ma.

**=> Đây gọi là Referential Integrity**

Tên hơi dài nhưng ý tưởng đơn giản:

```
Foreign Key đảm bảo mối quan hệ giữa các table không trỏ tới dữ liệu không tồn tại.
```

Ví dụ hợp lệ:

```
players
┌────┐
│ id │
├────┤
│  1 │ ──── orders.player_id = 1
│  2 │ ──── orders.player_id = 2
│  3 │
└────┘
```

Không hợp lệ:

```
players
┌────┐
│ id │
├────┤
│  1 │
│  2 │
└────┘
      ↑
orders.player_id = 999  ❌
```

## Parent và Child

Trong quan hệ này:

```
shop_players
      ↑
      │
      │ FK
      │
shop_orders
```

`shop_players` thường được gọi là Parent table.

`shop_orders` là Child table.

Vì:

```
shop_orders.player_id
```

phụ thuộc vào:

```
shop_players.id
```

Một player có thể có nhiều order:

```
yasuo
 ├── Sword
 ├── Armor
 └── Potion
```
Đây là quan hệ One-to-Many (1:N).

Ta sẽ học kỹ các loại quan hệ ở Chapter 4, nên chưa cần đào sâu vào đó ở bài này.

## Tạo FK bằng CONSTRAINT có tên

Giống những constraint mày đã học ở Chapter 1, nên đặt tên rõ ràng:

```SQL
CONSTRAINT FK_shop_orders_player
    FOREIGN KEY (player_id)
    REFERENCES shop_players(id)
```

Full:

```SQL
CREATE TABLE shop_orders (
    id INT PRIMARY KEY,
    player_id INT,
    item VARCHAR(50),
    price INT,

    CONSTRAINT FK_shop_orders_player
        FOREIGN KEY (player_id)
        REFERENCES shop_players(id)
);
```

Cách này tốt hơn để sau này biết chính xác constraint nào đang làm gì.

## FK không nhất thiết phải trỏ tới PRIMARY KEY

Trong thực tế, FK thường tham chiếu tới `PRIMARY KEY`, nhưng SQL Server cũng cho phép tham chiếu tới một column có `UNIQUE` phù hợp.

Ví dụ:

```SQL
username VARCHAR(50) UNIQUE
```

thì table khác có thể tham chiếu tới column đó.

Nhưng trong thiết kế database thông thường, dùng ID làm khóa chính để liên kết là lựa chọn phổ biến và dễ quản lý hơn.

Mày chỉ cần nhớ:

```
PK = định danh row trong table
FK = dùng để tham chiếu tới row ở table khác
```

## FK và JOIN là hai thứ khác nhau

Foreign Key:

`định nghĩa và bảo vệ mối quan hệ giữa các table.`

JOIN:

`dùng mối quan hệ đó để lấy dữ liệu từ nhiều table trong một query.`

Ví dụ:

```
FK:
orders.player_id → players.id
```

Sau này JOIN:

```SQL
SELECT ...
FROM shop_orders o
JOIN shop_players p
    ON o.player_id = p.id;
```

FK và JOIN thường đi cùng nhau, nhưng JOIN không bắt buộc phải có FK.

Đây là điểm sau này mày sẽ gặp.

## Cú pháp cần nhớ

| Mục đích      | Cú pháp                                                             |
| ------------- | ------------------------------------------------------------------- |
| Tạo FK        | `FOREIGN KEY (child_column) REFERENCES parent_table(parent_column)` |
| Đặt tên FK    | `CONSTRAINT FK_name FOREIGN KEY (...) REFERENCES ...`               |
| Tham chiếu PK | `FOREIGN KEY (player_id) REFERENCES shop_players(id)`               |
