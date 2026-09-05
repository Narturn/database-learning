-- =============================================
-- Chapter 3.1
-- =============================================
USE game2;
GO

-- Ex 1:
CREATE TABLE shop_orders(
    id INT IDENTITY(1, 1) PRIMARY KEY,
    player_id INT,
    item VARCHAR(50) NOT NULL,
    price INT NOT NULL,

    CONSTRAINT FK_shop_orders_player
        FOREIGN KEY (player_id)
        REFERENCES shop_players(id)
);
GO

-- Ex 2:
INSERT INTO shop_orders(player_id, item, price) VALUES
(1, 'Sword', 500),
(1, 'Armor', 800),
(2, 'Potion', 100)
GO
