# Chapter 4.2 - Normalization

## Normalization là gì?

Normalization là cách tổ chức database để:

- tránh dữ liệu bị lặp không cần thiết
- tránh dữ liệu mâu thuẫn
- dễ INSERT / UPDATE / DELETE
- các bảng có trách nhiệm rõ ràng

Ví dụ thiết kế tệ:

```
orders

id | customer_name | customer_phone | product
1  | Alice         | 0901           | Sword
2  | Alice         | 0901           | Armor
3  | Alice         | 0901           | Potion
```

Thông tin Alice bị lặp 3 lần.

Nếu Alice đổi số điện thoại:

```
0901 → 0902
```

phải sửa nhiều row.

**Cách tốt hơn**

Tách thành:

customers

```
id | name  | phone
1  | Alice | 0901
```

và:

orders

```
id | customer_id | product
1  | 1           | Sword
2  | 1           | Armor
3  | 1           | Potion
```

Bây giờ:

```
customers
    1
    │
    └────< orders
```

Thông tin customer chỉ nằm một chỗ.

## 1NF

1NF = mỗi ô chứa một giá trị nguyên tử, không chứa danh sách.

Sai:

```
id | username | phone_numbers
1  | Alice    | 0901, 0902, 0903
```

Một column đang chứa cả đống giá trị.

Tốt hơn:

```
users

id | username
1  | Alice
```
```
user_phones

user_id | phone
1       | 0901
1       | 0902
1       | 0903
```

## 2NF

2NF chủ yếu quan trọng khi bảng có composite key.

Ví dụ:

```
student_courses

student_id
course_id
student_name
course_name
```

PK:

```SQL
PRIMARY KEY (student_id, course_id)
```

Nhưng:

```
student_name
```

chỉ phụ thuộc vào:

```
student_id
```

không cần `course_id`.

Tương tự:

```
course_name
```

chỉ phụ thuộc vào:

```
course_id
```

-> dữ liệu đang nằm sai chỗ.

Tách thành:

```
students

student_id
student_name
```
```
courses

course_id
course_name
```
```
student_courses

student_id
course_id
```
Đây là ý chính của 2NF:

**Với composite key, thuộc tính không-key phải phụ thuộc vào toàn bộ key, không chỉ một phần của key.**

## 3NF 

3NF xử lý trường hợp:

```
A -> B -> C
```

Trong đó C thực ra phụ thuộc vào B, chứ không trực tiếp vào A.

Ví dụ:

```
employees

id
name
department_id
department_name
```

Ta có:

```
employee.id
    ↓
department_id
    ↓
department_name
```

`department_name` không thực sự là thông tin trực tiếp của employee.

Tách:

```
employees
id | name | department_id
```
```
departments
id | name
```

Bây giờ:

```
employees.department_id
        ↓
departments.id
```

Thông tin department chỉ tồn tại ở một nơi.

## Ghi nhớ

```
1NF
→ một ô = một giá trị

2NF
→ không phụ thuộc một phần của composite key

3NF
→ không để thuộc tính không-key phụ thuộc vòng qua thuộc tính không-key khác
```

Hoặc thực dụng hơn:

```
1NF → đừng nhét list vào một column

2NF → tách dữ liệu phụ thuộc từng phần của composite PK

3NF → tách dữ liệu phụ thuộc vào một thuộc tính trung gian
```
