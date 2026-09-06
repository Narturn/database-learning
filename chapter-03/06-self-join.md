# Chapter 3.6 - SELF JOIN

## SELF JOIN là gì?

SELF JOIN = một table JOIN với chính table đó.

Ví dụ có bảng:

```
employees

id    name       manager_id
1     Alice      NULL
2     Bob        1
3     Charlie    1
4     David      2
```

Ý nghĩa:

```
Alice
├── Bob
│   └── David
└── Charlie
```

manager_id chứa id của người quản lý.

Ví dụ:

Bob.manager_id = 1

-> Bob có manager là Alice.

## Tại sao phải JOIN table với chính nó?

Ta muốn query:

```
Employee    Manager
Bob         Alice
Charlie     Alice
David       Bob
```

Nhưng cả Employee và Manager đều nằm trong cùng một table.

Ta có thể:

```SQL
SELECT
    e.name AS employee,
    m.name AS manager
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.id;    
```

Chú ý:

```
employees AS e
employees AS m
```

Đây vẫn là cùng một table.

Chỉ là ta đặt 2 alias khác nhau để SQL biết mỗi phía đang đóng vai trò gì.

## Hiểu e và m

Đây là phần quan trọng nhất.

```SQL
FROM employees AS e
```

`e` đại diện cho:

```
employee
```

Còn:

```SQL
JOIN employees AS m
```

`m` đại diện cho:

```
manager
```

Sau đó:

```SQL
ON e.manager_id = m.id
```

nghĩa là:

```
manager_id của employee
        =
id của manager
```

Ví dụ Bob:

```
e:
id = 2
name = Bob
manager_id = 1

m:
id = 1
name = Alice
```

Match:

```
e.manager_id = 1
m.id         = 1
```

-> Bob -> Alice.

## SELF JOIN thực chất vẫn là JOIN

Đừng nghĩ SELF JOIN là một loại JOIN hoàn toàn khác.

Nó chỉ là:

```
JOIN
+
cùng một table
+
alias
```

Ví dụ:

```SQL
FROM employees e
JOIN employees m
    ON e.manager_id = m.id
```

Về bản chất:

```
employees e
     ↓
    JOIN
     ↑
employees m
```

Hai alias giúp ta coi cùng một table như hai vai trò khác nhau.

## Ví dụ với `shop_players`

Ta có thể thêm quan hệ kiểu:

```
player
    |
    └── referred_by
```

Ví dụ:

```
id    username    referred_by
1     yasuo       NULL
2     Bliat       1
3     d            1
10    yone        2
```

Ý nghĩa:

```
yasuo
├── Bliat
│   └── yone
└── d
```

Query:

```SQL
SELECT
    p.username AS player,
    r.username AS referred_by
FROM shop_players AS p
LEFT JOIN shop_players AS r
    ON p.referred_by = r.id;
```

Kết quả:

```
player    referred_by
yasuo     NULL
Bliat     yasuo
d         yasuo
yone      Bliat
```

Ở đây:

```
p = player
r = người giới thiệu
```

## SELF JOIN thường dùng ở đâu?

SELF JOIN rất hữu ích khi một bảng chứa quan hệ giữa các row trong chính bảng đó.

Ví dụ:

👔 Nhân viên -> quản lý

```
employee
manager
```

🌳 Cây thư mục

```
folder
parent_folder
```

🧑‍🤝‍🧑 Người giới thiệu

```
user
referrer
```

💬 Comment -> comment cha

```
comment
parent_comment
```

📦 Category -> category cha

```
category
parent_category
```

Tức là dữ liệu có dạng:

```
row này
  ↓
tham chiếu đến
  ↓
một row khác trong cùng table
```

thì SELF JOIN rất dễ xuất hiện.

## SELF JOIN không bắt buộc phải có FK

Ví dụ:

```SQL
ON e.manager_id = m.id
```

có thể có FK:

```SQL
FOREIGN KEY (manager_id)
REFERENCES employees(id)
```

Nhưng bản thân `JOIN` không yêu cầu phải có FK.

Giống những bài JOIN trước:

```
FK
→ bảo vệ tính hợp lệ của relationship

JOIN
→ dùng relationship đó để lấy dữ liệu
```

Hai thứ này vẫn là hai chuyện khác nhau.

## Tổng hợp cú pháp

| Mục đích                    | Cú pháp                                |
| --------------------------- | -------------------------------------- |
| SELF JOIN                   | `FROM A AS x JOIN A AS y ON condition` |
| Employee → Manager          | `ON e.manager_id = m.id`               |
| Giữ cả row không có manager | `LEFT JOIN`                            |
| Lọc sau JOIN                | `WHERE condition`                      |
| Hai vai trò của cùng table  | `A AS x`, `A AS y`                     |
