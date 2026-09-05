-- =============================================
-- Chapter 2.8
-- =============================================
USE game2;
GO

-- Ex 1:
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
GROUP BY level
HAVING COUNT(*) >= 2;
GO

-- Ex 2:
SELECT
    level,
    SUM(gold) AS total_gold
FROM shop_players
GROUP BY level
HAVING SUM(gold) >= 500;
GO

-- Ex 3:
SELECT
    level,
    COUNT(*) AS player_count
FROM shop_players
WHERE level >= 5
GROUP BY level
HAVING COUNT(*) >= 2;
GO

-- Ex 4:
SELECT
    level,
    SUM(gold) AS total_gold
FROM shop_players
GROUP BY level
HAVING SUM(gold) > 500
ORDER BY total_gold DESC;
GO

-- Ex 5:
SELECT
    level,
    COUNT(*) AS player_count,
    AVG(CAST(gold AS DECIMAL(10, 2))) AS average_gold
FROM shop_players
GROUP BY level
HAVING COUNT(*) >= 2
   AND AVG(CAST(gold AS DECIMAL(10, 2))) >= 5;
GO
