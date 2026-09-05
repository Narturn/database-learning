-- =============================================
-- Chapter 2.6
-- =============================================
USE game2;
GO

-- Ex 1:
SELECT COUNT(*) FROM shop_players;
GO

-- Ex 2:
SELECT SUM(gold) AS sum_gold
FROM shop_players;
GO

-- Ex 3:
SELECT
    MIN(level) AS min_level,
    MAX(level) AS max_level,
    AVG(CAST(level AS DECIMAL(10,2))) AS avg_level
FROM shop_players;
GO

-- Ex 4:
SELECT SUM(gold) AS total_gold
FROM shop_players
WHERE level >= 10;
GO

-- Ex 5:
SELECT
    COUNT(*) AS player_count,
    SUM(gold) AS total_gold,
    AVG(CAST(gold AS DECIMAL(10, 2))) AS average_gold,
    MIN(gold) AS min_gold,
    MAX(gold) AS max_gold
FROM shop_players;
GO