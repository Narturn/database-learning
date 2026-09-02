# Chapter 2.3 — Where

## Where là gì?

WHERE dùng để lọc những row thỏa mãn một điều kiện.

Ví dụ:

```SQL
SELECT *
FROM shop_players
WHERE level >= 10;
```

Database có:

id | username | level | gold
---|----------|-------|-----
1  | yasuo    | 10    | 500
2  | Bliat    | 1     | 0
3  | d        | 1     | 5
4  | yone     | 5     | 200
5  | faker    | 20    | 1000

thì WHERE level >= 10 sẽ giữ lại:

```
yasuo  | 10
faker  | 20
```
=>

```
SELECT *
FROM shop_players
        ↓
     tất cả row
        ↓
WHERE level >= 10
        ↓
   chỉ row phù hợp
```

### Cú pháp

```SQL
SELECT column1, column2
FROM table_name
WHERE condition;
```

Ví dụ:

```SQL
SELECT username, level
FROM shop_players
WHERE level >= 10;
```

WHERE không làm thay đổi database.

Nó chỉ quyết định row nào được trả về.

### Các toán tử so sánh

| Toán tử | Ý nghĩa           |
| ------- | ----------------- |
| `=`     | bằng              |
| `<>`    | khác              |
| `!=`    | khác              |
| `>`     | lớn hơn           |
| `<`     | nhỏ hơn           |
| `>=`    | lớn hơn hoặc bằng |
| `<=`    | nhỏ hơn hoặc bằng |

### So sánh chuỗi

Chuỗi phải dùng dấu nháy đơn:

```SQL
WHERE username = 'yasuo'
```

Không phải:

```SQL
WHERE username = yasuo
```

SQL sẽ hiểu yasuo như một identifier/column chứ không phải string literal.

### Kết hợp nhiều điều kiện với AND/OR

`AND` nghĩa là tất cả điều kiện đều phải đúng.

```SQL
SELECT *
FROM shop_players
WHERE level >= 10
  AND gold >= 500;
```

Có thể đọc:

Lấy player có level ít nhất 10 và gold ít nhất 500.

Ví dụ:

```
yasuo
level = 10
gold = 500
```

→ ✅

```
faker
level = 20
gold = 1000
```

→ ✅

```
player_x
level = 1
gold = 0
```

→ ❌

`OR` nghĩa là chỉ cần một điều kiện đúng.

```SQL
SELECT *
FROM shop_players
WHERE level >= 20
   OR gold >= 1000;
```

Player chỉ cần thỏa một trong hai.

```SQL
level >= 20
       OR
gold >= 1000
```

`AND` + `OR`

Ví dụ:

```SQL
WHERE level >= 10
  AND gold >= 500
  OR username = 'Bliat'
```

SQL xử lý AND trước OR

Nhưng đừng dựa vào việc nhớ precedence nếu query phức tạp.

Dùng ngoặc:

```SQL
WHERE
    (level >= 10 AND gold >= 500)
    OR username = 'Bliat';
```

Rõ ràng hơn rất nhiều.

### NOT

NOT phủ định kết quả của điều kiện.

```SQL
WHERE NOT level >= 10
```

nghĩa là:

```
level >= 10
```

→ đảo lại.

Tuy nhiên trong những trường hợp đơn giản, viết trực tiếp thường dễ đọc hơn:

```SQL
WHERE level < 10
```

NOT sẽ hữu ích hơn cho các điều kiện phức tạp sau này.

### BETWEEN

Dùng khi muốn lọc một khoảng.

```SQL
SELECT *
FROM shop_players
WHERE level BETWEEN 5 AND 10;
```

Nó tương đương:

```
level >= 5
AND
level <= 10
```

⚠️ BETWEEN bao gồm cả hai đầu.

```
5 ≤ level ≤ 10
```

### IN

Khi muốn kiểm tra một giá trị có nằm trong danh sách:

```SQL
SELECT *
FROM shop_players
WHERE username IN ('yasuo', 'yone', 'faker');
```

Tương đương về logic với:

```SQL
WHERE username = 'yasuo'
   OR username = 'yone'
   OR username = 'faker'
```

IN làm query dễ đọc hơn rất nhiều.

### LIKE

Dùng để tìm chuỗi theo pattern.

Ví dụ:

```SQl
WHERE username LIKE 'ya%'
```

% nghĩa là bất kỳ chuỗi ký tự nào, kể cả rỗng.

Nên:

```
ya%
```

có thể match:

```
ya
yasuo
yakuza
yahaha
```

Một số pattern cơ bản:

```SQL
LIKE 'ya%'
```

→ bắt đầu bằng ya

```SQL
LIKE '%ya'
```

→ kết thúc bằng ya

```SQL
LIKE '%ya%'
```

→ chứa ya

Có thêm _:

```SQL
LIKE 'y_suo'
```

_ đại diện cho đúng một ký tự.

Ví dụ:

```
yasuo
```

## WHERE không sửa dữ liệu

Cái này cực kỳ quan trọng.

```SQL
SELECT *
FROM shop_players
WHERE level >= 10;
```

không xóa player level thấp.

Nó chỉ không trả chúng về kết quả.

Database vẫn chứa:

```
yasuo
Bliat
d
yone
faker
player_x
```

Chỉ là query trả về một phần.

Tư duy:

```
Database
├── yasuo
├── Bliat
├── d
├── yone
├── faker
└── player_x
        ↓
     WHERE
        ↓
   lọc kết quả
```

Đừng nhầm:

WHERE   → lọc

DELETE  → xóa

UPDATE  → sửa

WHERE sau này sẽ xuất hiện trong cả UPDATE và DELETE, lúc đó nó trở nên cực kỳ nguy hiểm nếu viết sai.

Ví dụ:

```SQL
UPDATE players
SET gold = 0
WHERE id = 5;
```

→ sửa một player.

Nhưng:

```SQL
UPDATE players
SET gold = 0;
```

→ sửa toàn bộ player.

⚠️ Đây là lý do phải cực kỳ cẩn thận với WHERE khi bắt đầu dùng UPDATE và DELETE.dùng

## Tổng hợp cú pháp:

| Mục đích | Syntax |
|---|---|
| Lọc bằng | `WHERE column = value` |
| Lọc khác | `WHERE column <> value` |
| Lớn hơn / nhỏ hơn | `WHERE column > value` / `WHERE column < value` |
| AND | `WHERE condition1 AND condition2` |
| OR | `WHERE condition1 OR condition2` |
| NOT | `WHERE NOT condition` |
| Khoảng | `WHERE column BETWEEN value1 AND value2` |
| Danh sách | `WHERE column IN (value1, value2, ...)` |
| Pattern | `WHERE column LIKE 'pattern'` |