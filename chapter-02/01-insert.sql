-- =============================================
-- Chapter 2.1
-- =============================================
CREATE DATABASE game2;
GO

USE game2;
GO

-- Ex 1:
CREATE TABLE shop_players(
    id INT IDENTITY(1, 1) PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    level INT DEFAULT 1 CHECK(level >= 1),
    gold INT DEFAULT 0 CHECK(gold >= 0)
)
GO

INSERT INTO shop_players(username, level, gold)
VALUES ('yasuo', 10, 500);
GO

-- Ex 2:
INSERT INTO shop_players(username)
VALUES ('Bliat');
GO

-- Ex 3:
INSERT INTO shop_players(username, level, gold) VALUES
('yone', 5, 200),
('faker', 20, 1000),
('player_x', DEFAULT, DEFAULT);
GO

-- Ex 4:
INSERT INTO shop_players(username, level, gold) VALUES
-- A
('yasuo', 1, 1),
-- B
('b', 0, 1),
-- C
('c', 1, -100),
-- D
(NULL, 1, 1);
GO

-- Ex 5:
INSERT INTO shop_players
VALUES ('d', 1, 5); -- Người viết dễ nghi nhầm và đọc sẽ không biết được d, 1 hay 5 đó là gì 
GO

SELECT * FROM shop_players;
GO