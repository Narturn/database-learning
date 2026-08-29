# Chapter 1.5 — Primary Key and Indentity

## Primary Key là gì?

**Primary Key dùng để xác định duy nhất một row.**

Giả sử:

players

id | username | level
---|----------|------
1  | Alice    | 10
2  | Bob      | 20
3  | Charlie  | 15

Nếu backend muốn lấy chính xác Bob:

```SQL
SELECT *
FROM players
WHERE id = 2;
```

`id` chính là identity của row đó.

Một Primary Key phải đảm bảo:

1. Không NULL
2. Không trùng
3. Mỗi row có một giá trị xác định

Ví dụ:

```SQL
id INT PRIMARY KEY
```

## Tại sao không dùng username làm Primary Key?

Có thể làm:

```SQL
username VARCHAR(30) PRIMARY KEY
```

và về mặt kỹ thuật nó hợp lệ.

Nhưng thường không phải lựa chọn tốt.

Ví dụ user đổi username:

```
Yasuo
 ↓
Yone
```

Nếu username là Primary Key thì identity của user cũng thay đổi.

Trong khi:

```
id = 12345
```

vẫn là user đó.

```
id       → identity ổn định
username → thuộc tính có thể thay đổi
```

Đây là lý do các hệ thống thường có một ID riêng.

## IDENTITY là gì?

IDENTITY nói với SQL Server:

Tự động sinh giá trị cho column này khi INSERT row mới.

Cấu trúc:

```SQL
IDENTITY(seed, increment)
```

Ví dụ:

```SQL
id INT IDENTITY(1,1)
```

nghĩa:

```
seed      = 1
increment = 1
```

Các giá trị sẽ là:

```
1
2
3
4
5
...
```

## IDENTITY không đảm bảo ID liên tục

Khi mày tạo ID tự động bằng IDENTITY

ID có thể là:

```
1 → Yasuo
5 → Yone
```

tại sao ko phải là 1 - 2?

Vì các lần INSERT trước đó đã tiêu thụ giá trị ID.

Ví dụ:

```
INSERT A
→ cấp ID 1
→ thành công

INSERT B
→ cấp ID 2
→ UNIQUE fail

INSERT C
→ cấp ID 3
→ CHECK fail

INSERT D
→ cấp ID 4
→ CHECK fail

INSERT E
→ cấp ID 5
→ thành công
```

Kết quả:

```
1
5
```

**⚠️ Không được coi IDENTITY là bộ đếm số row.**

Nó là cơ chế sinh giá trị, không phải:

```
COUNT(*) + 1
```

Đây là lý do ID bị "hổng" là chuyện bình thường.

Nhưng ta không cần phải cố làm cho ID liên tục

Ví dụ:

```
1
2
3
4
```

xóa row 3:

```
1
2
4
```

vẫn ok!

Mày không cần cố sửa lại thành:

```
1
2
3
```

ID dùng để định danh, không phải để biểu diễn thứ tự.

Đừng cố biến database thành cuốn sổ điểm danh của lớp học. Con người đã có quá nhiều thứ phải đánh số rồi.

Nên là chỉ cần:

```SQL
INSERT INTO players (username)
VALUES ('Yasuo');
```

thay vì:

```SQL
INSERT INTO players (id, username)
VALUES (1, 'Yasuo');
```

Hãy để IDENTITY tự cấp ID và đảm bảo mày không làm bất cứ trò con bò nào đủ ngu

## Composite Primary Key

Primary Key có thể gồm nhiều column.

Ví dụ game có bảng:

player_items

player_id | item_id
----------|--------
1         | 100
1         | 101
2         | 100

Một player có thể sở hữu nhiều item.

Một item có thể thuộc nhiều player.

Ở đây:

```
player_id
```

không unique.

```
item_id
```

cũng không unique.

Nhưng:

```
(player_id, item_id)
```

lại unique.

Ta có thể:

```SQL
PRIMARY KEY (player_id, item_id)
```

Nghĩa là:

```
player 1 + item 100 → duy nhất
player 1 + item 101 → duy nhất
player 2 + item 100 → duy nhất
```

nhưng:

```
player 1 + item 100
player 1 + item 100
```
→ ❌

Composite key sẽ cực kỳ quan trọng khi học Many-to-Many.

## Primary Key vs UNIQUE

`PRIMARY KEY` và `UNIQUE` đều đảm bảo giá trị không bị trùng, nhưng mục đích khác nhau.

- `PRIMARY KEY`: định danh chính của mỗi row. Một table chỉ có một Primary Key.
- `UNIQUE`: đảm bảo một hoặc nhiều column không có giá trị trùng. Một table có thể có nhiều UNIQUE constraint.

Ví dụ:

```text
players
├── id       → PRIMARY KEY
├── username → UNIQUE
└── email    → UNIQUE
```