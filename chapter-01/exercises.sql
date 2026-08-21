-- Chapter 1
-- Exercise 1: Create the game database

CREATE DATABASE game_db;
GO

USE game_db;
GO

-- Exercise 2: Create the player table
CREATE TABLE players (
    id INT,
    name VARCHAR(50),
    level INT,
    gold INT
);
GO

-- Kiểm tra đang ở base nào
SELECT DB_NAME();
GO
-- Kiểm tra Table players
SELECT * FROM players;