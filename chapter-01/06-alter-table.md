# Chapter 1.6 — Alter table

## Alter table là gì?

CREATE TABLE dùng để tạo table mới.

```SQL
CREATE TABLE players (
    id INT,
    username VARCHAR(30)
);
```

Nhưng giả sử vài ngày sau mày nhận ra:

*"À đù, quên mất email."*

Table đã tồn tại rồi.

Không cần:

```SQL
DROP TABLE
↓
CREATE TABLE lại
```

Mà dùng:

```SQL
ALTER TABLE
```

Nó dùng để thay đổi cấu trúc của table đã tồn tại.

## Cú pháp

### Thêm column

```SQL
ALTER TABLE table_name
ADD column_name data_type;
```

Ví dụ:

```SQL
ALTER TABLE players_v2
ADD email VARCHAR(255);
```

Trước:

players_v2

id | username | level
---|----------|------
1  | Alice    | 10

Sau:

players_v2

id | username | level | email
---|----------|-------|------
1  | Alice    | 10    | NULL

Column mới mặc định sẽ có NULL đối với những row cũ nếu column cho phép NULL.

**Có thể thêm nhiều column trong một câu:**

```SQL
ALTER TABLE players_v2
ADD
    birth_date DATE,
    created_at DATETIME2;
```

### Thêm constraint vào table đã tồn tại

Ví dụ mày có:

```SQL
CREATE TABLE players_v2 (
    id INT,
    username VARCHAR(30)
);
```

Sau đó muốn username không được trùng.

Có thể thêm:

```SQL
ALTER TABLE players_v2
ADD CONSTRAINT UQ_players_v2_username
UNIQUE (username);
```

Cấu trúc:

```SQL
ADD CONSTRAINT
    tên_constraint
    loại_constraint
```

Tên constraint giúp mày dễ quản lý schema hơn.

Ví dụ:

```
PK_players_v2
UQ_players_v2_username
CK_players_v2_level
FK_characters_player
```

Sau này nhìn error message cũng dễ hiểu hơn.

### Xóa column

Cú pháp:

```SQL
ALTER TABLE table_name
DROP COLUMN column_name;
```

Ví dụ:

```SQL
ALTER TABLE players_v2
DROP COLUMN email;
```

**⚠️ Cực kỳ cẩn thận với DROP COLUMN.**

Nếu column chứa dữ liệu:

```
email
------------
a@gmail.com
b@gmail.com
c@gmail.com
```

thì drop column nghĩa là xóa luôn dữ liệu trong column đó.

Đây là một trong những câu lệnh mày đừng chạy lung tung trên database quan trọng.

### Xóa constraint

Giả sử:

```SQL
username VARCHAR(30) UNIQUE
```

SQL Server tạo một constraint cho UNIQUE.

Nếu muốn xóa constraint:

```SQL
ALTER TABLE players_v2
DROP CONSTRAINT UQ_players_v2_username;
```

Điểm quan trọng:

*"Muốn drop constraint, phải biết tên constraint."*

Đây là lý do lúc tạo constraint có tên rõ ràng rất hữu ích.

### Alter column

Dùng để thay đổi definition của column.

Ví dụ:

```SQL
ALTER TABLE players_v2
ALTER COLUMN username VARCHAR(50);
```

Từ:

```
VARCHAR(30)
```

thành:

```
VARCHAR(50)
```

**⚠️ Nhưng không phải thay đổi nào cũng được**

Ví dụ đang có:

username |
---------|
Alice    |
Bob      |

thì:

```SQL
ALTER COLUMN username INT;
```

có thể thất bại vì dữ liệu hiện tại không chuyển được sang INT.

Nói cách khác:

```
Schema change
     ↓
SQL Server
     ↓
phải đảm bảo dữ liệu hiện tại vẫn phù hợp
```

## ⚠️ Một số vấn đề: 

### ALTER TABLE không phải UPDATE

Hai cái này rất dễ nhầm.

**ALTER TABLE**

Thay đổi cấu trúc:

```
table
├── columns
├── constraints
└── schema
```

Ví dụ:

```SQL
ALTER TABLE players_v2
ADD email VARCHAR(255);
```

**UPDATE**

Thay đổi dữ liệu bên trong:

```SQL
UPDATE players_v2
SET username = 'Yasuo'
WHERE id = 1000;
```

Ví dụ:

```
ALTER
→ thay cái "kệ"

UPDATE
→ thay đồ trên cái "kệ"
```

Đây là distinction rất quan trọng.

### thêm NOT NULL

Giả sử table đang có:

**players**

id | username
---|---------
1  | Alice
2  | Bob
3  | Charlie

Mày chạy:

```SQL
ALTER TABLE players
ADD email VARCHAR(255) NOT NULL;
```

SQL Server sẽ phải đối mặt với:

```
Alice   → email = ???
Bob     → email = ???
Charlie → email = ???
```

Không có giá trị nào để điền.

Vì vậy việc thêm một column NOT NULL vào table đã có dữ liệu thường cần default hoặc một quy trình nhiều bước.

Ví dụ:

```SQL
ALTER TABLE players
ADD email VARCHAR(255) NOT NULL
    DEFAULT 'unknown@example.com';
```

**Nhưng không nên tùy tiện nhét dữ liệu giả chỉ để làm cho schema hợp lệ**

Thường sẽ xử lý theo kiểu:

1. ADD column cho phép NULL
2. UPDATE dữ liệu cũ
3. kiểm tra dữ liệu
4. chuyển column thành NOT NULL

Đây chính là tư duy migration mà sau này backend sẽ dùng.

### Migration

Đây là khái niệm mày chưa cần học sâu, nhưng cần biết tên.

Giả sử version 1:

```
players
├── id
├── username
└── level
```

Sau đó application cần email

Ta cần thay đổi database:

```
V1
 ↓
Migration
 ↓
V2
```

Ví dụ migration:

```SQL
ALTER TABLE players
ADD email VARCHAR(255);
```

**Hiện tại chưa cần học mấy tool đó.**

## Tổng hợp cú pháp:

| Mục đích | Syntax |
|---|---|
| Thêm column | `ALTER TABLE table ADD column data_type;` |
| Thêm constraint | `ALTER TABLE table ADD CONSTRAINT name ...;` |
| Đổi column | `ALTER TABLE table ALTER COLUMN column data_type;` |
| Xóa column | `ALTER TABLE table DROP COLUMN column;` |
| Xóa constraint | `ALTER TABLE table DROP CONSTRAINT name;` |
| PRIMARY KEY | `PRIMARY KEY (column)` |
| UNIQUE | `UNIQUE (column)` |
| CHECK | `CHECK (condition)` |
| DEFAULT | `DEFAULT value` |
| IDENTITY | `IDENTITY(seed, increment)` |
| Composite PK | `PRIMARY KEY (column1, column2)` |