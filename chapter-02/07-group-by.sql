-- =============================================
-- Chapter 2.7
-- =============================================
USE game2;
GO

-- Ex 1:
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level;
GO

-- Ex 2:
SELECT
    level,
    SUM(gold) AS total_gold
FROM shop_players
GROUP BY level;
GO

-- Ex 3:
SELECT
    level,
    CAST(AVG(gold AS DECIMAL(10, 2))) AS average_gold,
    MIN(gold) AS min_gold,
    MAX(gold) AS max_gold
FROM shop_players
GROUP BY level;
GO

-- Ex 4:
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
WHERE level >= 5
GROUP BY level;
GO

-- Ex 5:
SELECT
    level,
    SUM(gold) AS total_gold
FROM shop_players
GROUP BY level
ORDER BY total_gold DESC;
GO

-- Ex 6:
SELECT
    level,
    gold,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level, gold;
GO
