-- =============================================
-- Chapter 2.9
-- =============================================
USE game2;
GO

-- Ex 1:
DECLARE @min_level INT;
SET @min_level = 10;

SELECT level
FROM shop_players
WHERE level >= @min_level;
GO

-- Ex 2:
DECLARE @bonus INT;
SET @bonus = 300;

SELECT username,
       gold,
       gold + @bonus AS new_gold
FROM shop_players;
GO

-- Ex 3:
DECLARE @top_n INT;
SET @top_n = 3;

SELECT TOP (@top_n) *
FROM shop_players
ORDER BY gold DESC;
GO

-- Ex 4:
DECLARE @bonus INT;
SET @bonus = 1000;

SELECT
    username,
    gold,
    gold + @bonus AS new_gold
FROM shop_players
WHERE level >= 10
GO
