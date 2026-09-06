-- =============================================
-- Chapter 3.4
-- =============================================
USE game2;
GO

SELECT
    p.username,
    o.item
FROM shop_players AS p
FULL OUTER JOIN shop_orders AS o
    ON p.id = o.player_id
WHERE p.id IS NULL
   OR o.id IS NULL;
GO