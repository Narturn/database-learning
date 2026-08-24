# Chapter 1.1 — Database & Table

## 📖 Concepts

### 1. Database

Database là một tập hợp dữ liệu được tổ chức và quản lý có hệ thống.

Có thể hình dung Database giống như một "cái tủ" chứa các table của một ứng dụng.

Ví dụ:

```text
SQL Server
│
├── master
├── tempdb
├── model
├── msdb
└── game_db
```

`game_db` là database mà chúng ta tạo để thực hành.

Một database có thể chứa nhiều table:

```text
game_db
│
├── players
├── characters
├── items
├── inventory
└── ...
```

> Đây chỉ là cách hình dung. Database không thực sự là "cái tủ", và table không nhất thiết phải đại diện trực tiếp cho một loại đối tượng.

### 2. CREATE DATABASE

SQL Server dùng câu lệnh:

```sql
CREATE DATABASE database_name;
```

Ví dụ:

```sql
CREATE DATABASE game_db;
```

Câu lệnh trên tạo một database có tên `game_db`.

### 3. Table

Table là nơi dữ liệu được tổ chức thành các dòng và cột.

Ví dụ:

```text
players

id | name    | level | gold
---|---------|-------|-----
1  | Alice   | 10    | 500
2  | Bob     | 20    | 800
3  | Charlie | 5     | 100
```

Trong ví dụ trên:

* `players` là **table**.
* `id`, `name`, `level`, `gold` là **columns**.
* Mỗi dòng dữ liệu là một **row**.

### 4. Column

Column đại diện cho một loại thông tin trong table.

Ví dụ:

```text
id
name
level
gold
```

### 5. Row

Row là một bản ghi dữ liệu trong table.

Ví dụ:

```text
1 | Alice | 10 | 500
```

là một row của table `players`.

### 6. CREATE TABLE

SQL Server dùng:

```sql
CREATE TABLE table_name (
    column_name data_type
);
```

Ví dụ:

```sql
CREATE TABLE players (
    id INT,
    name VARCHAR(50),
    level INT,
    gold INT
);
```

Table `players` có 4 columns:

```text
id     → INT
name   → VARCHAR(50)
level  → INT
gold   → INT
```

### 7. Chọn Database

SQL Server có thể chứa nhiều database. Tạo một database không tự động chuyển sang database đó.

Để làm việc với `game_db`:

```sql
USE game_db;
GO
```

Sau đó các câu lệnh tiếp theo sẽ được thực hiện trong database đó.

---

## 💻 Syntax

### Tạo Database

```sql
CREATE DATABASE database_name;
```

### Chọn Database

```sql
USE database_name;
GO
```

### Tạo Table

```sql
CREATE TABLE table_name (
    column_name data_type
);
```

### Kiểm tra Database hiện tại

```sql
SELECT DB_NAME();
GO
```

### Xem các table trong Database hiện tại

```sql
SELECT name
FROM sys.tables;
GO
```

---

## 🧪 Mission

### Tạo Database

```sql
CREATE DATABASE game_db;
GO
```

### Chọn Database

```sql
USE game_db;
GO
```

### Tạo Table

```sql
CREATE TABLE players (
    id INT,
    name VARCHAR(50),
    level INT,
    gold INT
);
GO
```

### Kiểm tra Database hiện tại

```sql
SELECT DB_NAME();
GO
```

### Kiểm tra Table

```sql
SELECT name
FROM sys.tables;
GO
```

---

## 🐛 Mistakes

### Mistake 1 — Sai tên table

Đề yêu cầu:

```text
players
```

Nhưng đã từng tạo:

```text
player
```

Code có thể chạy nhưng không đúng yêu cầu.

### Mistake 2 — Typo tên column

Đã từng viết:

```text
lever
```

thay vì:

```text
level
```

Đây là lỗi có thể khiến query sau này không tìm thấy column cần thiết.

### Mistake 3 — Quên chọn Database

Tạo `game_db` không có nghĩa SQL Server tự chuyển sang `game_db`.

Cần:

```sql
USE game_db;
GO
```

trước khi tạo table bên trong database đó.
