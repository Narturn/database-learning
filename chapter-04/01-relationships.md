# Chapter 4.1 - Quan hệ 1-1, 1-N, N-N

## Quan hệ 1-1

Một row ở A tương ứng với tối đa một row ở B, và ngược lại.

Ví dụ:

```
users
id    username
1     yasuo
2     Bliat
```

và:

```
user_profiles
id    user_id    full_name
1     1          Yasuo Vang
2     2          Bliat Suka
```

Quan hệ:

```
User 1 ───── 1 Profile
User 2 ───── 1 Profile
```

Một user có một profile.

Một profile thuộc về một user.

Trong SQL thường dùng:

```
user_profiles.user_id
    ↓
users.id
```

và `user_id` phải có `UNIQUE` để đảm bảo một user không có nhiều profile.

Ví dụ:

```SQL
CREATE TABLE user_profiles (
    id INT IDENTITY PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100),

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);
```

Điểm quan trọng:

```
FK
→ tạo reference

UNIQUE
→ ngăn nhiều profile cùng trỏ vào một user
```

## Quan hệ 1-N

Ví dụ:

```
Player
   │
   ├── Order
   ├── Order
   └── Order
```

Một player có nhiều orders.

Nhưng:

```
Order
   │
   └── Player
```

Mỗi order chỉ thuộc về một player.

Ta có:

```
shop_players
id
1
2
```
```
shop_orders
id    player_id
1     1
2     1
3     2
```

Quan hệ:

```
Player 1 ─────< Order 1
              < Order 2

Player 2 ─────< Order 3
```

Trong database:

```
shop_orders.player_id
        ↓
shop_players.id
```

**FK nằm ở phía N.**

Đây là quy tắc cực kỳ quan trọng:

`Trong quan hệ 1-N, FK thường nằm ở bảng phía N.`

Ví dụ:

```
players       orders
   1            N
   │             │
   └─────────────┘
                 ↑
             player_id
```

## Quan hệ N-N

Đây là lúc database bắt đầu đòi hỏi thêm một bảng trung gian.

Ví dụ game:

```
Player
  ↕
Item
```

Một player có nhiều item.

Một item cũng có thể thuộc nhiều player.

Ví dụ:

```
yasuo
├── Sword
├── Armor
└── Potion
```
```
Bliat
├── Sword
└── Potion
```

Ta không nên làm:

```
players
id    items
1     Sword, Armor, Potion
```

vì nhét nhiều giá trị vào một column là thiết kế database rất tệ.

Thay vào đó tạo bảng trung gian:

```
players
items
player_items
```

`player_items:`

```
player_id    item_id
1            1
1            2
1            3
2            1
2            3
```

Quan hệ:

```
Player
  │
  │ 1-N
  ↓
player_items
  ↑
  │ N-1
  │
Item
```

Về tổng thể:

`Player N ───── N Item`

Nhưng database triển khai nó thành:

`Player 1 ─── N player_items N ─── 1 Item`

Đây chính là cách xử lý N-N.

## Tóm tắt 3 loại

| Quan hệ | Ví dụ           | Cách triển khai |
| ------- | --------------- | --------------- |
| **1-1** | User → Profile  | FK + `UNIQUE`   |
| **1-N** | Player → Orders | FK ở phía N     |
| **N-N** | Player ↔ Items  | Bảng trung gian |
