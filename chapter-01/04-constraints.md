# Chapter 1.4 — Constraints

## 📖 Concepts

### Constraints là gì?

Hiểu đơn giản:

**Constraint = luật mà dữ liệu trong database bắt buộc phải tuân theo.**

Ví dụ game:

```text
players
├── id
├── username
├── level
└── gold
```

Tao có thể đặt luật:

```text
id       → không được NULL
username → không được NULL
level    → phải >= 1
username → không được trùng
```

Database sẽ tự kiểm tra những luật này.

Nên là nếu Backend có gửi sai

```text
level = 0
```

thì SQL server sẽ từ chối

Đây là tư duy cực kỳ quan trọng:

```text
Backend
   ↓
gửi dữ liệu
   ↓
Database
   ↓
kiểm tra luật
   ↓
✅ hợp lệ / ❌ từ chối
```

Database không nên mù quáng tin application.

### Cách sử dụng constraints

#### NOT NULL:

có thể xem lại ở [1.3 — NULL](./chapter-01/03-null.md)

#### UNIQUE:

UNIQUE đảm bảo không có hai row có cùng giá trị ở column đó.

Ví dụ:

```SQL
username VARCHAR(50) UNIQUE
```
Database:

```text
id | username
---|---------
1  | Alice
2  | Bob
```
OK.

Nhưng:
```text
3 | Alice
```
→ ❌

Vì Alice đã tồn tại.

Unique thường được dùng ở:

```text
email
username
phone_number
```

#### CHECK

CHECK dùng để giới hạn giá trị theo một điều kiện.

Ví dụ:

```SQL
level INT CHECK (level >= 1)
```

#### DEFAULT

DEFAULT quy định:

**Nếu INSERT không cung cấp giá trị thì database tự dùng giá trị mặc định.**

Ví dụ:

```SQL
level INT DEFAULT 1
```

Nếu:

```SQL
INSERT INTO players (username)
VALUES ('Alice');
```

thì database tự tạo:

```text
username | level
---------|------
Alice    | 1
```

#### PRIMARY KEY

**Đây là một trong những khái niệm quan trọng nhất của database.**

Primary Key dùng để xác định duy nhất một row trong table.

Ví dụ:

```text
players

id | username
---|---------
1  | Alice
2  | Bob
3  | Charlie
```

id có thể là Primary Key.

```SQL
id INT PRIMARY KEY
```

Điều đó đảm bảo id:

```text
NULL       ❌
trùng nhau ❌
duy nhất    ✅
```

Sẽ được để cập lại và nói rõ hơn trong [1.5 — Primary Key](./chapter-01/05-primary-key.md)

#### FOREIGN KEY

Foreign Key dùng để tạo và bảo vệ mối quan hệ giữa các table.

Ví dụ:

```text
players
id
1
2
3

characters
id | player_id
---|----------
10 | 1
11 | 1
12 | 2
```

`characters.player_id` có thể tham chiếu: `players.id`

→ database biết:

Character này thuộc player nào.

## 🧪 Exercise

### Exercise 1 — Thiết kế Player

Tạo table:

```text
constrained_players
```

với:

| Column     | Yêu cầu                                    |
| ---------- | ------------------------------------------ |
| `id`       | số nguyên, Primary Key                     |
| `username` | tối đa 30 ký tự, bắt buộc, không trùng     |
| `level`    | số nguyên, mặc định `1`, phải >= `1`       |
| `gold`     | số nguyên, mặc định `0`, phải >= `0`       |
| `email`    | tối đa 255 ký tự, có thể NULL, không trùng |

### Exercise 2

Sau khi tạo table, thử INSERT: (Đã hoàn thành trong exercises.sql)sql

### Exercise 3

```text
id              -> PRIMARY KEY
username        -> NOT NULL UNIQUE
email           -> UNIQUE
password_hash   -> NOT NULL
age             -> Không cần constraints
created_at      -> Không cần constraints
```

## Tổng hợp

| Constraint    | Chức năng                             |
| ------------- | ------------------------------------- |
| `NOT NULL`    | Không cho phép thiếu giá trị          |
| `UNIQUE`      | Không cho phép trùng giá trị          |
| `CHECK`       | Ép dữ liệu thỏa điều kiện             |
| `DEFAULT`     | Tự cung cấp giá trị nếu không truyền  |
| `PRIMARY KEY` | Xác định duy nhất một row             |
| `FOREIGN KEY` | Liên kết và bảo vệ quan hệ giữa table |