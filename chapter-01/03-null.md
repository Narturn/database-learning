# Chapter 1.2 — NULL

## 📖 Concepts

### NULL là gì?

NULL có thể hiểu đơn giản là:

Không có giá trị / chưa có giá trị / giá trị không được biết.

Ví dụ:

```text
player

id | username | birth_date
---|----------|-----------
1  | Alice    | 2000-01-01
2  | Bob      | NULL
```

Bob tồn tại. Nhưng birth_date của Bob chưa hề có giá trị

### ⚠️ NULL không phải là 0

Đây là cái đầu tiên phải nhớ

Ví dụ:

```text
gold = 0
```

nghĩa là:

Player có gold, nhưng số lượng là 0.

Còn:

```text
gold = NULL
```

nghĩa là:

Không có giá trị gold.

### ⚠️ NULL không phải là ''

Empty string:

```text
''
```

là một chuỗi rỗng.

Còn:

```text
NULL
```

là không có giá trị.

Ví dụ:

```text
username = ''
```

→ username tồn tại nhưng là chuỗi rỗng.

```text
username = NULL
```

→ username chưa có giá trị.

### Một số hành vi đặc biệt của NULL

Giả sử:

```text
gold
----
100
0
NULL
```

Mày có thể nghĩ:

```SQL
WHERE gold = NULL
```

sẽ tìm dòng NULL.

Nhưng thực tế là**KHÔNG**

Đây là một trong những trap kinh điển của SQL.

Để kiểm tra NULL, dùng:

```SQL
WHERE gold IS NULL
```

và:

```SQL
WHERE gold IS NOT NULL
```

Ví dụ:

```SQL
SELECT *
FROM players
WHERE gold IS NULL;
```

→ lấy player chưa có giá trị gold.

**Nhớ ```= NULL``` Không hề hoạt động**

Khi so sánh với NULL, kết quả không đơn giản là true hoặc false.

Ví dụ:

```
NULL = NULL
```

không được coi là TRUE.

Vì SQL đang nói:

*"Tao không biết giá trị này là gì, nên tao cũng không thể khẳng định hai giá trị không biết đó bằng nhau."*

### Column mặc định là NULL

Nếu mày viết:

```SQL
CREATE TABLE players (
    id INT,
    name VARCHAR(50)
);
```

thì về mặc định column có thể nhận NULL.

Ví dụ:

```SQL
INSERT INTO players (id)
VALUES (1);
```

name không được cung cấp.

Nếu column cho phép NULL:

```
id | name
---|------
1  | NULL
```

**Nhưng**

Nếu mày muốn bắt buộc column phải có giá trị:

```SQL
CREATE TABLE players (
    id INT,
    name VARCHAR(50) NOT NULL
);
```

Bây giờ:

```SQL
INSERT INTO players (id)
VALUES (1);
```

→ ❌ lỗi.

Name bắt buộc phải có giá trị.

Vì vậy:
```SQL
INSERT INTO players (id, name)
VALUES (1, 'Alice');
```

→ ✅

### Tại sao NOT NULL lại quan trọng?

Hãy nghĩ database của một web app.

Ví dụ bảng:

```text
users
```

có:

```text
email
password_hash
username
```

Nếu hệ thống yêu cầu mọi user phải có email:

```SQL
email VARCHAR(255) NOT NULL
```

Database sẽ tự bảo vệ dữ liệu.

Backend có bug:

```text
INSERT user
↓
quên email
↓
SQL Server
↓
❌ từ chối
```

Nếu không có NOT NULL:

```text
INSERT user
↓
quên email
↓
SQL Server
↓
✅ cho vào
↓
database bẩn
```

Đây chính là tư duy database engineering:

**Đừng chỉ tin backend. Database cũng phải tự bảo vệ tính toàn vẹn dữ liệu.**

Vì vậy khi thiết kế database, mày phải hỏi:

*Column này có bắt buộc phải có giá trị không?*

Nếu có:

```SQL
NOT NULL
```

Nếu không:

```SQL
NULL
```

## 🧪 Exercises

### Exercise 1 — Tạo bảng

Tạo table:

```text
null_test
```

với:

```text
id
username
email
age
```

Yêu cầu:

```text
id: số nguyên.
username: tối đa 50 ký tự và bắt buộc có giá trị.
email: tối đa 255 ký tự và có thể NULL.
age: số nguyên và có thể NULL.
```

### Exercise 2 — INSERT dữ liệu NULL

Thêm 3 người:
```text
Alice
Bob
Charlie
```

Yêu cầu:

```text
Alice
→ có email
→ có age

Bob
→ không có email
→ có age

Charlie
→ có email
→ không có age
```

Tự quyết định cách viết INSERT.

### Exercise 3 — Truy vấn NULL

Viết query để:

A

Tìm những người không có email.

B

Tìm những người có email.

C

Tìm những người không có age.

D

Tìm những người có age.

### Exercise 4 — Suy luận

Không code.

Một bảng users có:

```text
username    -- NOT NULL
email       -- NULL
phone       -- NULL
middle_name -- NULL
```

Theo mày column nào nên NOT NULL, column nào có thể NULL?
