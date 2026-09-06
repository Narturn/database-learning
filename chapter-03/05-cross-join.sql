-- =============================================
-- Chapter 3.5
-- =============================================
USE game2;
GO

-- Ex 1:
CREATE TABLE shop_rarities (
    id INT IDENTITY(1,1) PRIMARY KEY,
    rarity VARCHAR(20) NOT NULL
);

INSERT INTO shop_rarities (rarity)
VALUES
    ('Common'),
    ('Rare'),
    ('Epic');
GO

-- Ex 2:
SELECT
    p.username,
    r.rarity
FROM shop_players AS p
CROSS JOIN shop_rarities AS r;
GO
