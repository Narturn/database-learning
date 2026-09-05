-- =============================================
-- Chapter 2.9
-- =============================================
USE game2;
GO

SELECT * FROM shop_players;
GO

/*
 id          username                       level       gold       
 ----------- ------------------------------ ----------- -----------
           1 yasuo                                   10         500
           2 Bliat                                    1           0
           3 d                                        1           5
          10 yone                                     5         200
          11 faker                                   20        1000
          12 player_x                                 1           0
          15 Ex5                                     10         500
          17 ex_order                                10        6000
*/

-- Ex 1:
UPDATE shop_players
SET gold = 1000
WHERE id = 1;
GO

-- Ex 2:
UPDATE shop_players
SET gold = gold + 500
WHERE level >= 10;
GO

-- Ex 3:
UPDATE shop_players
SET level = 2
WHERE gold = 0;
GO

-- Ex 4:
DELETE FROM shop_players
WHERE gold = 0;
GO

SELECT * FROM shop_players;
GO

/* 
id          username                       level       gold       
----------- ------------------------------ ----------- -----------
          1 yasuo                                   10        1500
          2 Bliat                                    2           0
          3 d                                        1           5
         10 yone                                     5         200
         11 faker                                   20        1500
         15 Ex5                                     10        1000
         17 ex_order                                10        6500
*/