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
-- =============================================4
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

SELECT * FROM constrained_players;
GO