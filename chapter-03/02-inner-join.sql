-- =============================================
-- Chapter 3.2
-- =============================================
USE game2;
GO

-- Ex 1:
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
INNER JOIN shop_orders AS o
    ON p.id = o.player_id
GO

-- Ex 2:
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
INNER JOIN shop_orders AS o
    ON p.id = o.player_id
WHERE o.price >= 500
GO

-- Ex 3:
SELECT
    p.username,
    p.level,
    o.item,
    o.price
FROM shop_players AS p
INNER JOIN shop_orders AS o
    ON p.id = o.player_id
WHERE p.level >= 10
GO

-- Ex 4:
SELECT 
    p.username,
    o.item
FROM shop_players AS p
INNER JOIN shop_orders AS o
    ON p.id = o.player_id;
GO