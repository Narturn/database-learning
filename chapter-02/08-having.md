# Chapter 2.8 — HAVING

## `HAVING` là gì?

Ví dụ:

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level;
```

Ta có:

```
level   player_count
1       3
5       1
10      3
20      1
```

Giờ muốn:

`Chỉ lấy những level có ít nhất 2 player.`

Dùng:

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level
HAVING COUNT(*) >= 2;
```

Kết quả:

```
level   player_count
1       3
10      3
```

HAVING đã lọc group.

## `WHERE` vs `HAVING`

Đây là thứ phải nhớ rất chắc.

`WHERE`

Lọc row trước khi GROUP BY.

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
WHERE level >= 5
GROUP BY level;
```

Nó có nghĩa:

**Chỉ giữ player có level >= 5, rồi mới chia nhóm.**

`HAVING`

Lọc group sau khi GROUP BY.

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level
HAVING COUNT(*) >= 2;
```

Nó có nghĩa:

**Chia nhóm trước, rồi chỉ giữ group có ít nhất 2 player.**

Cứ nhớ:

```
FROM
 ↓
WHERE       ← lọc row
 ↓
GROUP BY    ← chia group
 ↓
HAVING      ← lọc group
 ↓
SELECT
 ↓
ORDER BY
```

Ví dụ:

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
WHERE level >= 5
GROUP BY level
HAVING COUNT(*) >= 2
ORDER BY player_count DESC;
```

## `HAVING` thường đi với Aggregate

Đây là pattern rất phổ biến:

```SQL
HAVING COUNT(*) >= 2
```

hoặc:

```SQL
HAVING SUM(gold) > 1000
```

hoặc:

```SQL
HAVING AVG(gold) >= 500
```

Ví dụ:

`Chỉ lấy các level có tổng gold trên 1000.`

```SQL
SELECT
    level,
    SUM(gold) AS total_gold
FROM shop_players
GROUP BY level
HAVING SUM(gold) > 1000;
```

Với dữ liệu hiện tại:

```
level 10 → 7000
```
nên level 10 được giữ.

## `HAVING` không chỉ lọc bằng Aggregate

Có thể:

```SQL
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level
HAVING level >= 10;
```

Nhưng về mặt tư duy, điều này thường nên được viết:

```SQL
WHERE level >= 10
```

trước GROUP BY nếu mục tiêu thực sự là lọc row theo level.

Vì vậy:

`HAVING đặc biệt hữu ích khi điều kiện phụ thuộc vào kết quả aggregate của group.`

Đây là cách dùng mày nên ưu tiên.

## Một lỗi rất hay gặp

Mày viết:

```SQL
SELECT
    level,
    COUNT(*)
FROM shop_players
WHERE COUNT(*) >= 2
GROUP BY level;
```

❌ Sai.

Vì `WHERE` hoạt động trước `GROUP BY`.

Lúc `WHERE` chạy, `COUNT(*)` của group chưa tồn tại.

Muốn lọc theo `COUNT(*)`:

```SQL
HAVING COUNT(*) >= 2
```

✅

Đây là lý do WHERE và HAVING không thể tùy tiện thay cho nhau.

## Tổng hợp cú pháp

| Cú pháp                             | Ý nghĩa                   |
| ----------------------------------- | ------------------------- |
| `GROUP BY column HAVING condition`  | Lọc group                 |
| `HAVING COUNT(*) >= n`              | Lọc group theo số row     |
| `HAVING SUM(column) > value`        | Lọc group theo tổng       |
| `HAVING AVG(column) > value`        | Lọc group theo trung bình |
| `WHERE ... GROUP BY ... HAVING ...` | Lọc row rồi lọc group     |
| `... HAVING ... ORDER BY ...`       | Lọc group rồi sắp xếp     |
