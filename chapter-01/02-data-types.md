# Chapter 1.2 — Data Types

## 📖 Concepts

### Data Types là gì?

Data Types là quy định cho máy tính biết loại kiểu dữ liệu nào được phép lưu trữ một cột trong bảng và nó chiếm bao nhiêu bộ nhớ.

Hiểu đơn giản: Khi bạn tạo một ngăn kéo (cột), bạn phải dán nhãn cho nó. Ngăn kéo dán nhãn "Số" thì không thể nhét "Chữ" vào được.

Ví dụ:

```text
id       → số nguyên
name     → chuỗi
level    → số nguyên
gold     → số nguyên
```

### Các nhóm Data Types phổ biến:

```text
| Type        | Dùng cho               | Ví dụ              |
| ----------- | ---------------------- | ------------------ |
| `INT`       | Số nguyên              | `100`              |
| `BIGINT`    | Số nguyên rất lớn      | `900000000000`     |
| `DECIMAL`   | Số thập phân chính xác | `99.95`            |
| `VARCHAR`   | Chuỗi độ dài thay đổi  | `"Alice"`          |
| `CHAR`      | Chuỗi độ dài cố định   | `"VN"`             |
| `DATE`      | Ngày                   | `2026-08-21`       |
| `DATETIME2` | Ngày + giờ             | `2026-08-21 14:30` |
| `BIT`       | Đúng/sai               | `0`, `1`           |
```

### ⚠️ Nguyên tắc quan trọng:

Đừng chọn data type dựa trên "có vẻ chứa được".

Ví dụ:

```SQL
age INT
```

hợp lý.

Nhưng:
```SQL
age VARCHAR(10)
```
cũng có thể chứa: "20"

nhưng không nên.

Vì age bản chất là số, vậy database nên biết nó là số.

Tương tự:
```text
price VARCHAR(20) ❌
price DECIMAL(...) ✅
```

Nếu để giá tiền thành string, sau này phép tính sẽ trở nên ngu học:
```text
"100" + "20"
```

không phải cách database nên xử lý tiền.

## 🧪 Mission

### Exercise 1 — Thiết kế Player

Tạo một table mới:

```text
player_profile
```

với các thông tin:

```text
| Column       | Yêu cầu                          |
| ------------ | -------------------------------- |
| `id`         | số nguyên                        |
| `username`   | tối đa 30 ký tự                  |
| `level`      | số nguyên                        |
| `money`      | số tiền có thể có phần thập phân |
| `birth_date` | ngày sinh                        |
| `created_at` | thời điểm tạo                    |
| `is_banned`  | có/không                         |
```

Yêu cầu

Tự chọn data type phù hợp cho từng column.

### Exercise 2 — Giải thích lựa chọn

Comment trong exercises.sql, giải thích:

1. Tại sao username dùng VARCHAR?
2. Tại sao level dùng INT?
3. Tại sao money không dùng VARCHAR?
4. Tại sao created_at không dùng VARCHAR?
5. Tại sao is_banned có thể dùng BIT?

### Exercise 3 — Suy luận

Không cần code.

Một game có:

```text
player_id
total_damage
player_name
account_created
last_login
is_online
```

Tự chọn data type cho từng

### Solving exercises 3

```text
player_id       - INT
total_damage    - INT (Số Dam nên là số nguyên để dễ tính toán)
player_name     - VARCHAR(30)
account_created - DATETIME2
last_login      - DATETIME2 
is_online       - BIT (Có / Không)
```