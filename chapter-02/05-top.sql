USE game2;

SELECT TOP 3 username, level
FROM shop_players;
GO

SELECT TOP 3 username, level
FROM shop_players
ORDER BY level DESC;
GO

SELECT TOP 2 username, gold
FROM shop_players
ORDER BY gold DESC;
GO

SELECT TOP 3 username, level, gold
FROM shop_players
WHERE level >= 5
ORDER BY gold DESC;
GO

SELECT TOP 3 username, level, gold
FROM shop_players
ORDER BY level DESC, gold DESC;
GO
