-- =============================================
-- Chapter 2.2
-- =============================================
USE game2;
GO

-- Ex 1
SELECT * FROM shop_players;
GO

-- Ex 2
SELECT username, level
FROM shop_players;
GO

-- Ex 3
SELECT 
    username player_name,
    level player_level,
    gold player_gold
FROM shop_players;
GO

-- Ex 4
SELECT
    username,
    gold,
    gold + 100 AS gold_after_bonus
FROM shop_players;

SELECT * FROM shop_players;
GO

-- Ex 5
INSERT INTO shop_players(username, level, gold)
VALUES ('Ex5', 10, 500);
GO

SELECT level FROM shop_players
GO

SELECT DISTINCT level FROM shop_players
GO