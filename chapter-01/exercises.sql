-- =============================================
-- Chapter 1.1
-- =============================================

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

-- =============================================
-- Chapter 1.2
-- =============================================

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

-- =============================================
-- Chapter 1.3
-- =============================================

-- Exercise 1-2

CREATE TABLE null_test (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    age INT
);
GO

-- Alice: Có email + Có age
INSERT INTO null_test (username, email, age)
VALUES (N'Alice', 'alice@gmail.com', 22);

-- Bob: Không có email (bỏ qua cột email hoặc dùng từ khóa NULL) + Có age
INSERT INTO null_test (username, age) 
VALUES (N'Bob', 25);

-- Charlie: Có email + Không có age
INSERT INTO null_test (username, email, age) 
VALUES (N'Charlie', 'charlie@gmail.com', NULL);
GO

-- SELECT * FROM null_test;

-- -- Exercise 3

-- -- A: Tìm những người KHÔNG CÓ email
-- SELECT * FROM null_test 
-- WHERE email IS NULL;
-- GO

-- -- B: Tìm những người CÓ email
-- SELECT * FROM null_test 
-- WHERE email IS NOT NULL;
-- GO

-- -- C: Tìm những người KHÔNG CÓ age
-- SELECT * FROM null_test 
-- WHERE age IS NULL;
-- GO

-- -- D: Tìm những người CÓ age
-- SELECT * FROM null_test 
-- WHERE age IS NOT NULL;
-- GO

-- =============================================
-- Chapter 1.4
-- =============================================
IF OBJECT_ID('dbo.constrained_players', 'U') IS NOT NULL
    DROP TABLE dbo.constrained_players;
GO

CREATE TABLE constrained_players (
    id INT IDENTITY(1,1) PRIMARY KEY,       -- PK, KHÔNG THỂ NULL
    username VARCHAR(30) NOT NULL UNIQUE,   -- Tối đa 30, NOT NULL, KHÔNG TRÙNG
    level INT DEFAULT 1 CHECK (level >= 1), -- Default = 1, Ràng buộc >= 1
    gold INT DEFAULT 0 CHECK (gold >= 0),   -- Default = 0, Ràng buộc >= 0
    email VARCHAR(255) UNIQUE               -- Có thể NULL, KHÔNG TRÙNG
);
GO

-- A. Một player hợp lệ (Thành công ✅)
INSERT INTO constrained_players (username, level, gold, email)
VALUES ('giao2803', 10, 500, 'giao@gmail.com');
GO

-- B. Hai player có cùng username (Thất bại ❌ - Lỗi Vi phạm UNIQUE Constraint)
INSERT INTO constrained_players (username, level, gold, email)
VALUES ('giao2803', 1, 0, 'giao_other@gmail.com');
GO

-- C. Level = 0 (Thất bại ❌ - Lỗi Vi phạm CHECK Constraint)
INSERT INTO constrained_players (username, level, gold, email)
VALUES ('player_c', 0, 100, 'c@gmail.com');
GO

-- D. Gold = -100 (Thất bại ❌ - Lỗi Vi phạm CHECK Constraint)
INSERT INTO constrained_players (username, level, gold, email)
VALUES ('player_d', 5, -100, 'd@gmail.com');
GO

-- E. Không truyền level và gold (Thành công ✅ - Tự động nhận DEFAULT level=1, gold=0)
INSERT INTO constrained_players (username, email)
VALUES ('player_e', 'e@gmail.com');
GO

-- F. Hai player có cùng email (Thất bại ❌ - Lỗi Vi phạm UNIQUE Constraint)
INSERT INTO constrained_players (username, email)
VALUES ('player_f', 'giao@gmail.com'); -- Trùng email của giao2803 ở câu A
GO

-- G. id = NULL (Thất bại ❌ vì PRIMARY KEY không cho phép NULL.)
INSERT INTO constrained_players (id, username, email)
VALUES (NULL, 'player_g', 'g@gmail.com');
GO

-- SELECT * FROM constrained_players;
-- GO

-- =============================================
-- Chapter 1.5
-- =============================================

-- Exercise 1 — Tạo Player 

CREATE TABLE players_v2 (
    id INT IDENTITY(1000, 1) PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE,
    email VARCHAR(255) UNIQUE,
    level INT DEFAULT 1 CHECK (level >= 1)
);

-- Exercise 2 — UNIQUE vs PRIMARY KEY

INSERT INTO players_v2 (username, email, level)
VALUES ('player1', '1@gmail.com', 3);
GO

-- username trùng
INSERT INTO players_v2 (username, email, level)
VALUES ('player1', 'a@gmail.com', 4);
GO

-- email trùng
INSERT INTO players_v2 (username, email, level)
VALUES ('player2', '1@gmail.com', 5);
GO

-- id trùng
INSERT INTO players_v2 (id, username, email, level)
VALUES (1000, 'player3', '3@gmail.com', 3);
GO

-- Exercise 5 — Composite Primary Key

CREATE TABLE player_items(
    player_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT,
    PRIMARY KEY (player_id, item_id)
);
GO

-- 2. Insert các bản ghi hợp lệ
INSERT INTO player_items (player_id, item_id, quantity) VALUES (1, 100, 5);
INSERT INTO player_items (player_id, item_id, quantity) VALUES (1, 101, 2);
INSERT INTO player_items (player_id, item_id, quantity) VALUES (2, 100, 10);
GO

-- 3. Thêm trùng bộ (player_id = 1, item_id = 100)
INSERT INTO player_items (player_id, item_id, quantity) VALUES (1, 100, 20);
GO

-- SELECT * FROM players_v2;
-- SELECT * FROM player_items;
-- GO

-- =============================================
-- Chapter 1.6
-- =============================================
-- ex 1-2
DROP TABLE IF EXISTS schema_lab;
GO

CREATE TABLE schema_lab(
    id INT IDENTITY(1, 1) PRIMARY KEY,
    username VARCHAR(30) NOT NULL,
    level INT
);
GO

-- Insert 3 player
INSERT INTO schema_lab (username, level) VALUES 
('yasuo', 10),
('yone', 5),
('Bliat', 8);
GO

ALTER TABLE schema_lab
ADD email VARCHAR(255);
GO

-- Ex 3-4
-- 1. Thêm Constraint UNIQUE với tên UQ_schema_lab_username
ALTER TABLE schema_lab
ADD CONSTRAINT UQ_schema_lab_username UNIQUE (username);
GO

-- 2. Thử phá DB: Thêm một username trùng với người đã có ('yasuo')
INSERT INTO schema_lab (username, level) 
VALUES ('yasuo', 99);
GO

-- Thay đổi kích thước cột username lên 50 ký tự
ALTER TABLE schema_lab
ALTER COLUMN username VARCHAR(50) NOT NULL;
GO

-- Kiểm tra lại cấu trúc (schema) của bảng để xác nhận
SELECT 
    column_name, 
    data_type, 
    character_maximum_length, 
    is_nullable
FROM information_schema.columns
WHERE table_name = 'schema_lab';
GO

-- ex 5-6-7
-- Thêm column country (Ban đầu cho phép NULL)
ALTER TABLE schema_lab
ADD country VARCHAR(50) NULL;
GO

-- Điền country cho cả 3 player cũ
UPDATE schema_lab SET country = 'Vietnam' WHERE username = 'yasuo';
UPDATE schema_lab SET country = 'Japan'   WHERE username = 'yone';
UPDATE schema_lab SET country = 'USA'     WHERE username = 'Bliat';
GO

-- Kiểm tra xác nhận không còn NULL
SELECT * FROM schema_lab WHERE country IS NULL;
GO

-- Đổi column country thành NOT NULL
ALTER TABLE schema_lab
ALTER COLUMN country VARCHAR(50) NOT NULL;
GO

-- 1. Xóa UNIQUE constraint của username
ALTER TABLE schema_lab
DROP CONSTRAINT UQ_schema_lab_username;
GO

-- 2. Thử Insert username trùng ('yasuo')
INSERT INTO schema_lab (username, level, country) 
VALUES ('yasuo', 99, 'Vietnam');
GO

-- 3. Kiểm tra lại bảng
SELECT * FROM schema_lab;
GO

-- 1. Thêm cột tạm
ALTER TABLE schema_lab
ADD temporary_data VARCHAR(100);
GO

-- 2. Xóa cột tạm bằng ALTER TABLE ... DROP COLUMN
ALTER TABLE schema_lab
DROP COLUMN temporary_data;
GO

-- 3. Kiểm tra lại bảng (Cột temporary_data đã biến mất)
SELECT * FROM schema_lab;
GO

-- DJTME t làm dơ vcl :))