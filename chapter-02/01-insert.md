# Chapter 2.1 — Insert

## Insert là gì?

INSERT dùng để thêm row mới vào table.

Ví dụ:

players

id | username | level
---|----------|------
1  | Yasuo    | 10
2  | Yone     | 5

Muốn thêm:

```
Bliat | 8
```

thì dùng INSERT.

### INSERT một row

Cú pháp cơ bản:

```SQL
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

Ví dụ:

```SQL
INSERT INTO players (username, level)
VALUES ('Yasuo', 10);
```

SQL Server sẽ tạo một row mới.

**Không nhất thiết phải INSERT tất cả column**

Ví dụ:

```SQL
CREATE TABLE players (
    id INT IDENTITY(1,1),
    username VARCHAR(30) NOT NULL,
    level INT DEFAULT 1,
    gold INT DEFAULT 0
);
```

Khi INSERT:

```SQL
INSERT INTO players (username)
VALUES ('Yasuo');
```

SQL Server sẽ xử lý:

```
id       → IDENTITY tự sinh
username → Yasuo
level    → DEFAULT 1
gold     → DEFAULT 0
```

Kết quả:

id | username | level | gold
---|----------|-------|-----
1  | Yasuo    | 1     | 0

Đây là lý do DEFAULT và IDENTITY cực kỳ hữu ích.

### Column cho phép NULL

Nếu column cho phép NULL, mày có thể không truyền nó.

Ví dụ:

```SQL
email VARCHAR(255)
```

không có NOT NULL.

Thì:

```SQL
INSERT INTO players (username)
VALUES ('Yasuo');
```

có thể tạo:

username | email
---------|------
Yasuo    | NULL

Nhưng nhớ:

**không truyền column**

và:

**email = NULL**

là hai cách khác nhau về mặt câu lệnh, dù trong trường hợp này kết quả có thể giống nhau.

### INSERT nhiều row

Không cần viết 5 câu INSERT.

Có thể:

```SQL
INSERT INTO players (username, level)
VALUES
    ('Yasuo', 10),
    ('Yone', 5),
    ('Bliat', 8);
```

Một câu lệnh tạo nhiều row.

Kết quả:

id | username | level
---|----------|------
1  | Yasuo    | 10
2  | Yone     | 5
3  | Bliat    | 8

Đây là syntax mày sẽ dùng rất thường xuyên.

### INSERT không truyền column list?

Có thể viết:

```SQL
INSERT INTO players
VALUES ('Yasuo', 10);
```

Nhưng tao không muốn mày dùng kiểu này trong bài học.

Vì nó phụ thuộc vào thứ tự column trong table.

Ví dụ table thay đổi:

```
username
level
gold
```

thành:

```
username
gold
level
```

thì câu INSERT cũ có thể trở thành vấn đề.

Tốt hơn:

```SQL
INSERT INTO players (username, level)
VALUES ('Yasuo', 10);
```

Tức là:

**Nói rõ dữ liệu này đi vào column nào.**

### INSERT và IDENTITY

Nếu:

```SQL
id INT IDENTITY(1,1)
```

thì bình thường:

```SQL
INSERT INTO players (username)
VALUES ('Yasuo');
```

không cần truyền id.

SQL Server tự làm:

```
INSERT
 ↓
IDENTITY
 ↓
id = 1
```

Sau đó:

```SQL
INSERT INTO players (username)
VALUES ('Yone');
```

→ id = 2.

Đây là workflow bình thường.

### INSERT và Constraints

Ví dụ:

```SQL
username VARCHAR(30) NOT NULL UNIQUE
```

Nếu:

```SQL
INSERT INTO players (username)
VALUES (NULL);
```

→ ❌ NOT NULL

Nếu:

```SQL
INSERT INTO players (username)
VALUES ('Yasuo');
```

trong khi Yasuo đã tồn tại:

→ ❌ UNIQUE

Nếu:

```SQL
level INT CHECK (level >= 1)
```

thì:

```SQL
INSERT INTO players (username, level)
VALUES ('PlayerX', -10);
```

→ ❌ CHECK

Nói cách khác:

```
INSERT
  ↓
Database kiểm tra constraints
  ↓
┌───────────────┐
│ Hợp lệ?       │
└───────────────┘
   ↓       ↓
  YES      NO
   ↓       ↓
INSERT    ERROR
```

### INSERT không phải UPDATE

Cực kỳ quan trọng.

**INSERT**

Tạo row mới

```SQL
INSERT INTO players (...)
VALUES (...);
```

```
1 Yasuo
2 Yone
3 Bliat ← mới
```

**UPDATE**

Thay đổi row đã tồn tại

```SQL
UPDATE players
SET level = 20
WHERE id = 1;
```

```
1 Yasuo level 10
        ↓
1 Yasuo level 20
```

## Tổng hợp cú pháp:

| Mục đích | Syntax |
|---|---|
| INSERT một row | `INSERT INTO table (column1, column2) VALUES (value1, value2);` |
| INSERT nhiều row | `INSERT INTO table (column1, column2) VALUES (v1, v2), (v3, v4);` |
| INSERT dùng DEFAULT | `INSERT INTO table (column) VALUES (value);` |
| INSERT không chỉ định column | `INSERT INTO table VALUES (value1, value2);` |
