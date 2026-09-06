# Chapter 3.4 - FULL OUTER JOIN

## FULL OUTER JOIN là gì?

`FULL OUTER JOIN` giữ:

- Tất cả rows của table bên trái
- Tất cả rows của table bên phải
- Row nào match thì ghép lại
- Row nào không match thì phía còn lại nhận NULL

Ví dụ:

```SQL
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
FULL OUTER JOIN shop_orders AS o
    ON p.id = o.player_id;
```

Với dữ liệu hiện tại, kết quả:

```
yasuo      Sword      500
yasuo      Armor      800
Bliat      Potion     100
d          NULL       NULL
yone       NULL       NULL
faker      NULL       NULL
Ex5        NULL       NULL
ex_order   NULL       NULL
```

Tại sao?

`shop_players` có những player chưa có order, nên chúng vẫn xuất hiện.

`shop_orders` hiện tại tất cả đều có player tương ứng, nên không có row nào chỉ thuộc phía `shop_orders`.

## So sánh với các JOIN đã học

Giả sử:

```
A = shop_players
B = shop_orders
```

`INNER JOIN`

```
A ∩ B
```

Chỉ lấy phần match.

`LEFT JOIN`

```
Tất cả A
+ B match
```

`RIGHT JOIN`

```
Tất cả B
+ A match
```

`FULL OUTER JOIN`

```
Tất cả A
+ tất cả B
```

Có thể hình dung:

```
INNER
        MATCH

LEFT
████████████
LEFT + MATCH

RIGHT
        ████████████
        MATCH + RIGHT

FULL
████████████████████
       ALL
```

Nhưng đừng phụ thuộc vào hình. Cái cần nhớ là:

`FULL = giữ cả hai phía.`

## Khi nào FULL OUTER JOIN hữu ích?

Một trường hợp điển hình là tìm dữ liệu có ở một bên nhưng không có ở bên kia.

Ví dụ:

```
A:
1
2
3

B:
2
3
4
```

`FULL OUTER JOIN` sẽ cho:

```
1   NULL
2   2
3   3
NULL 4
```

Nhờ vậy có thể phát hiện:

```
1 → chỉ có A
2 → có cả hai
3 → có cả hai
4 → chỉ có B
```

Đây là một cách khá hữu ích để đối chiếu dữ liệu giữa hai nguồn.

## FULL OUTER JOIN + IS NULL

Muốn tìm những row không có match ở cả hai phía, có thể dùng:

```SQL
SELECT
    p.username,
    o.item
FROM shop_players AS p
FULL OUTER JOIN shop_orders AS o
    ON p.id = o.player_id
WHERE p.id IS NULL
   OR o.id IS NULL;
```

Với database hiện tại:

```
d
yone
faker
Ex5
ex_order
```

được lấy ra vì chúng không có order.

Nếu sau này `shop_orders` có một order với `player_id` không tồn tại trong `shop_players`, row đó cũng sẽ xuất hiện.

⚠️ Với FK hiện tại thì database không cho tạo order mồ côi, nhưng pattern này vẫn quan trọng khi làm việc với dữ liệu từ nhiều nguồn hoặc table không có FK.

## FULL OUTER JOIN không phải "INNER + LEFT + RIGHT"

Đừng nghĩ:

```
FULL = chạy 3 JOIN rồi cộng lại
```

Không phải.

Nó là một loại JOIN riêng, có logic:

```
match
+
unmatched left
+
unmatched right
```

## Tổng hợp cú pháp

| Mục đích            | Cú pháp                                     |
| ------------------- | ------------------------------------------- |
| FULL JOIN           | `FROM A FULL OUTER JOIN B ON A.id = B.a_id` |
| Tìm row không match | `WHERE A.id IS NULL OR B.id IS NULL`        |
| Match + cả hai phía | `FULL OUTER JOIN`                           |
