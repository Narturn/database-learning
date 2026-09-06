-- =============================================
-- Chapter 3.3
-- =============================================
USE game2;
GO

-- Ex 1:
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
LEFT JOIN shop_orders AS o
    ON p.id = o.player_id;
GO

-- Ex 2:
SELECT
    p.username,
    o.item,
    o.price
FROM shop_players AS p
LEFT JOIN shop_orders AS o
    ON p.id = o.player_id
WHERE o.id IS NULL;
GO

-- Ex 3:
SELECT
    p.username,
    p.level,
    o.item,
    o.price
FROM shop_players AS p
LEFT JOIN shop_orders AS o
    ON p.id = o.player_id
WHERE p.level >= 10;
GO

-- Ex 4:

SELECT
    p.username,
    o.item,
    o.price
FROM shop_orders AS o
RIGHT JOIN shop_players AS p
    ON p.id = o.player_id;
GO