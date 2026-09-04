USE game2;

-- Ex 1:
SELECT TOP 3 username, level
FROM shop_players;
GO

-- Ex 2:
SELECT TOP 3 username, level
FROM shop_players
ORDER BY level DESC;
GO

-- Ex 3:
SELECT TOP 2 username, gold
FROM shop_players
ORDER BY gold DESC;
GO

-- Ex 4:
SELECT TOP 3 username, level, gold
FROM shop_players
WHERE level >= 5
ORDER BY gold DESC;
GO

-- Ex 5:
SELECT TOP 3 username, level, gold
FROM shop_players
ORDER BY level DESC, gold DESC;
GO
