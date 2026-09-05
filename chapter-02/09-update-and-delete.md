# Chapter 2.9 — UPDATE & DELETE

## `UPDATE` là gì?

`UPDATE` dùng để thay đổi dữ liệu đã tồn tại trong bảng.

Ví dụ bảng players:

| id | username | level | gold |
| -: | -------- | ----: | ---: |
|  1 | yasuo    |    10 |  500 |
|  2 | Bliat    |     1 |    0 |
|  3 | d        |     1 |    5 |

Muốn đổi level của yasuo từ 10 → 15:

```SQL
UPDATE players
SET level = 15
WHERE username = 'yasuo';
```

Sau đó:

| id | username | level | gold |
| -: | -------- | ----: | ---: |
|  1 | yasuo    |    15 |  500 |

### Cấu trúc cơ bản

```SQL
UPDATE table_name
SET column = value
WHERE condition;
```

Ví dụ:

```SQL
UPDATE players
SET gold = 1000
WHERE id = 1;
```

Có thể sửa nhiều cột cùng lúc:

```SQL
UPDATE players
SET level = 20,
    gold = 2000
WHERE id = 1;
```

### UPDATE có thể tính toán

Đây mới là thứ khá hay.

```SQL
UPDATE players
SET gold = gold + 100
WHERE level >= 10;
```

Nó sẽ lấy giá trị hiện tại rồi cộng thêm 100.

Ví dụ:

```
gold = 500
```

sẽ thành:

```
gold = 600
```

### WHERE trong UPDATE cực kỳ quan trọng

```SQL
UPDATE players
SET gold = 0
WHERE id = 1;
```

Chỉ player `id = 1` bị sửa.

Nhưng:

```SQL
UPDATE players
SET gold = 0;
```

Không có ``WHERE`.

=> Tất cả rows đều bị sửa.

Đây là một trong những lỗi SQL kinh điển.

⚠️⚠️⚠️⚠️⚠️ Quy tắc:

**Trước khi chạy `UPDATE`, thường nên chạy `SELECT` với chính điều kiện `WHERE` trước.**

Ví dụ:

```SQL
SELECT *
FROM players
WHERE level >= 10;
```

Nếu thấy đúng những row muốn sửa:

```
UPDATE players
SET gold = gold + 100
WHERE level >= 10;
```

Cách này cực kỳ đáng tập thành thói quen.

## `DELETE` là gì?

`DELETE` dùng để xóa rows khỏi bảng.

```SQL
DELETE FROM players
WHERE id = 3;
```

Player id = 3 biến mất.

Cấu trúc:

```SQL
DELETE FROM table_name
WHERE condition;
```

### DELETE cũng có thể xóa nhiều rows

```SQL
DELETE FROM players
WHERE level = 1;
```

Tất cả player có level = 1 sẽ bị xóa.

Một lần nữa, `WHERE` quyết định phạm vi.

### DELETE không có WHERE

```SQL
DELETE FROM players;
```

=> Xóa toàn bộ rows trong bảng.

Bảng vẫn tồn tại.

Ví dụ:

```
players
├── id
├── username
├── level
└── gold
```

vẫn còn.

Chỉ là:

```
players = 0 rows
```

⚠️⚠️⚠️⚠️⚠️

Đừng nhầm:

```SQL
DELETE FROM players;
```

với:

```SQL
DROP TABLE players;
```

`DELETE` xóa dữ liệu.

`DROP TABLE` xóa cả table.

## UPDATE vs DELETE

| Lệnh             | Tác dụng                  |
| ---------------- | ------------------------- |
| `UPDATE`         | sửa dữ liệu               |
| `DELETE`         | xóa rows                  |
| `WHERE`          | xác định rows bị tác động |
| Không có `WHERE` | tác động toàn bộ bảng     |

Ví dụ:

```SQL
UPDATE players
SET level = 10
WHERE id = 1;
```

-> sửa row.

```SQL
DELETE FROM players
WHERE id = 1;
```

-> xóa row.

## quy trình

Khi chuẩn bị sửa hoặc xóa:

Bước 1: `SELECT` kiểm tra

```SQL
SELECT *
FROM players
WHERE level = 1;
```

Bước 2: kiểm tra kết quả

Ví dụ thấy đúng 3 rows.

Bước 3: `UPDATE` hoặc `DELETE`

```SQL
UPDATE players
SET level = 2
WHERE level = 1;
```

Hoặc:

```SQL
DELETE FROM players
WHERE level = 1;
```

Làm đúng quy trình sẽ hạn chế việc nghịch nguu.

## Tổng hợp cú pháp

| Mục đích               | Cú pháp                                            |
| ---------------------- | -------------------------------------------------- |
| UPDATE                 | `UPDATE table SET column = value WHERE condition;` |
| Nhiều column           | `SET col1 = value1, col2 = value2`                 |
| UPDATE theo giá trị cũ | `SET gold = gold + 100`                            |
| DELETE                 | `DELETE FROM table WHERE condition;`               |
| Xóa toàn bộ rows       | `DELETE FROM table;`                               |
