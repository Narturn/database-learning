-- =============================================
-- Chapter 2.3
-- =============================================
USE game2;
GO

-- Ex 1:
SELECT * FROM shop_players
WHERE level = 10
GO

SELECT * FROM shop_players
WHERE level > 10
GO

SELECT * FROM shop_players
WHERE gold < 500
GO

SELECT * FROM shop_players
WHERE level <> 1
GO

-- Ex 2:
SELECT * FROM shop_players
WHERE username = 'yasuo';
GO

SELECT * FROM shop_players
WHERE username = 'mal';
GO

-- Ex 3:
SELECT * FROM shop_players
WHERE level >= 10 and gold >= 500;
GO

-- Ex 4:
SELECT * FROM shop_players
WHERE level >= 20 or gold >= 1000;
GO

-- Ex 5:
SELECT * FROM shop_players
WHERE level BETWEEN 5 AND 10;
GO

-- Ex 6:
SELECT * FROM shop_players
WHERE username IN ('yasuo', 'yone', 'faker');
GO

-- Ex 7:
SELECT * FROM shop_players
WHERE username LIKE 'y%a%o'
GO
