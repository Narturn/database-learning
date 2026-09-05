# Chapter 2.10 — T-SQL Variables

## Variable là gì?

Variable là một biến tạm thời trong lúc SQL đang chạy, dùng để lưu một giá trị.

Ví dụ:

```SQL
DECLARE @bonus INT;
SET @bonus = 500;

SELECT @bonus;
```

Kết quả:

`500`

Trong SQL Server, tên biến thường bắt đầu bằng `@`.

## `DECLARE`

Dùng để khai báo biến:

```SQL
DECLARE @variable_name data_type;
```

Ví dụ:

```SQL
DECLARE @level INT;
DECLARE @username VARCHAR(50);
DECLARE @gold DECIMAL(10, 2);
```

Lúc này biến đã tồn tại nhưng chưa nhất thiết có giá trị.

## 'SET'

Dùng để gán giá trị cho biến:

```SQL
DECLARE @level INT;

SET @level = 10;

SELECT @level;
```

Có thể hiểu:

```
DECLARE → tạo biến
SET     → đưa giá trị vào biến
```

## Dùng variable trong SELECT

```SQL
DECLARE @min_level INT;

SET @min_level = 10;

SELECT *
FROM shop_players
WHERE level >= @min_level;
```

Ở đây:

```
@min_level = 10
```

nên SQL thực chất đang lọc:

```
WHERE level >= 10
```

Điểm hay là mày có thể đổi giá trị biến mà không phải sửa câu query.

## Variable với UPDATE

Ví dụ muốn tăng gold theo một mức bonus:

```SQL
DECLARE @bonus INT;

SET @bonus = 200;

UPDATE shop_players
SET gold = gold + @bonus
WHERE level >= 10;
```

Tất cả player level ≥ 10 được cộng `200`.

## Variable với TOP

DECLARE @limit INT;

```SQL
SET @limit = 3;

SELECT TOP (@limit) *
FROM shop_players
ORDER BY gold DESC;
```

`@limit` quyết định lấy bao nhiêu row

## ⚠️ Một điểm cần nhớ

Variable ở đây là biến trong lúc thực thi câu lệnh/script, không phải column của table.

Ví dụ:

```SQL
DECLARE @bonus INT;
SET @bonus = 500;
```

`@bonus` không được thêm vào `shop_players`.

Sau khi batch/script kết thúc, biến đó cũng không phải dữ liệu được lưu trong database.

## Tổng hợp cú pháp

| Mục đích      | Cú pháp                 |
| ------------- | ----------------------- |
| Khai báo      | `DECLARE @name TYPE;`   |
| Gán giá trị   | `SET @name = value;`    |
| Dùng biến     | `WHERE column >= @name` |
| TOP với biến  | `TOP (@name)`           |
| Hiển thị biến | `SELECT @name;`         |
