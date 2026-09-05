-- =============================================
-- Chapter 2.4
-- =============================================
USE game2;
GO

SELECT * FROM shop_players;
GO

-- EX 1:
SELECT username, level FROM shop_players
ORDER BY level
GO

-- Ex 2:
SELECT username, level FROM shop_players
ORDER BY level DESC;
GO

-- Ex 3:
SELECT username, gold FROM shop_players
ORDER BY gold DESC;
GO

-- Ex 4:
SELECT username, level, gold FROM shop_players
ORDER BY level DESC, gold DESC;
GO

-- Ex 5:
SELECT username FROM shop_players
ORDER BY gold DESC;
GO

-- Ex 6:
SELECT
    username,
    gold,
    gold + 100 AS bonus_gold
FROM shop_players
ORDER BY bonus_gold DESC;
GO

-- Ex 7:
SELECT * FROM shop_players
WHERE level >= 5
ORDER BY gold DESC;
GO