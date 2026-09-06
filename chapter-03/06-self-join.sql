-- =============================================
-- Chapter 3.6
-- =============================================
USE game2;
GO

CREATE TABLE shop_employees (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    manager_id INT NULL
);

INSERT INTO shop_employees (name, manager_id)
VALUES
    ('Alice', NULL),
    ('Bob', 1),
    ('Charlie', 1),
    ('David', 2);
GO

-- Ex 1:
SELECT 
    e.name AS employee,
    m.name AS manager
FROM shop_employees AS e
INNER JOIN shop_employees AS m
    ON e.manager_id = m.id;
GO

-- Ex 2:
SELECT 
    e.name AS employee,
    m.name AS manager
FROM shop_employees AS e
LEFT JOIN shop_employees AS m
    ON e.manager_id = m.id;
GO

-- Ex 3:
SELECT 
    e.name AS employee
FROM shop_employees AS e
INNER JOIN shop_employees AS m
    ON e.manager_id = m.id
WHERE e.manager_id = 1;
GO