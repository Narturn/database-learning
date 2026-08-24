-- Chapter 1.1
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
-- SELECT DB_NAME();
-- GO

-- Kiểm tra Table players
-- SELECT * FROM players;

-- Chapter 1.2
CREATE TABLE player_profile (
    id INT,
    username VARCHAR(30),   -- Narturn, Đấng-Yasuo,...
    level INT,              -- Level 1, 2, 3,...
    money DECIMAL(20, 2),   -- Tiền có thể sở hữu số thập phân vd: 13 đô 50 cent3 (3,5$)
    birth_date DATE,
    created_at DATE,        -- Sử dụng DATE để có thể sử dụng các phép toán tính toán (VD: người chơi đã tạo acc trong bao lâu)
    is_banned BIT           -- BIT lưu trữ '1 hoặc 0' có thể dùng cho 'đúng hoặc sai'
);
GO

SELECT * FROM player_profile;