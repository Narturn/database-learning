# Chapter 3.5 - CROSS JOIN

## CROSS JOIN là gì?

Ví dụ có:

`shop_players`

```
id   username
1    yasuo
2    Bliat
3    d
```

`shop_items`

```
id   item
1    Sword
2    Armor
```

Nếu:

```SQL
SELECT *
FROM shop_players
CROSS JOIN shop_items;
```

thì kết quả là:

```
yasuo   Sword
yasuo   Armor
Bliat   Sword
Bliat   Armor
d       Sword
d       Armor
```

Tức là:

```
mỗi player
    ×
mọi item
```

### Không có `ON`

Khác với:

```SQL
INNER JOIN
    ON p.id = o.player_id
```

`CROSS JOIN` chỉ viết:

```SQL
SELECT ...
FROM A
CROSS JOIN B;
```

Không có:

```SQL
ON ...
```

vì nó không cần tìm row match.

Nó lấy tất cả combination.

### Số lượng rows

Đây là thứ phải nhớ.

Nếu:

```
A có 3 rows
B có 2 rows
```

thì:

```
3 × 2 = 6 rows
```

Nếu:

```
A có 100 rows
B có 50 rows
```

thì:

```
100 × 50 = 5000 rows
```

Nếu:

```
A = 10,000 rows
B = 10,000 rows
```

thì:

```
100,000,000 rows
```

💀

Đây là lý do CROSS JOIN có thể rất nguy hiểm về hiệu năng nếu dùng vô tội vạ.

## CROSS JOIN khác INNER JOIN thế nào?

`INNER JOIN`:

```
A
 ↓
tìm row match ở B
 ↓
chỉ lấy match
```

`CROSS JOIN`:

```
A
 ↓
ghép với TẤT CẢ B
 ↓
không quan tâm match
```

Ví dụ:

```
Players:
yasuo
Bliat

Items:
Sword
Armor
Potion
```

CROSS JOIN:

```
yasuo   Sword
yasuo   Armor
yasuo   Potion

Bliat   Sword
Bliat   Armor
Bliat   Potion
```

-> `2 × 3 = 6 rows`.

## CROSS JOIN dùng để làm gì?

Không phải cứ "ghép tất cả" là vô dụng.

Một số trường hợp thực tế:

Tạo tất cả combination

Ví dụ game có:

```
Character:
Warrior
Mage
Archer
```

và:

```
Difficulty:
Easy
Normal
Hard
```

Muốn tạo tất cả khả năng:

```
Warrior   Easy
Warrior   Normal
Warrior   Hard
Mage      Easy
Mage      Normal
Mage      Hard
Archer    Easy
Archer    Normal
Archer    Hard
```

-> `3 × 3 = 9 combinations`.

## CROSS JOIN không phải JOIN dựa trên relationship

Đây là điểm quan trọng.

Các JOIN trước:

```
p.id = o.player_id
```

có relationship rõ ràng.

Còn:

```SQL
FROM shop_players p
CROSS JOIN shop_rarities r
```

không cần relationship giữa hai table.

Nó đơn giản là:

`"Đưa cho tao mọi combination giữa hai tập dữ liệu này."`

## Tổng hợp cú pháp

| Mục đích            | Cú pháp                               |
| ------------------- | ------------------------------------- |
| CROSS JOIN          | `FROM A CROSS JOIN B`                 |
| CROSS JOIN + filter | `FROM A CROSS JOIN B WHERE condition` |
| Số rows             | `rows(A) × rows(B)`                   |
