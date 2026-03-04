-- 1️⃣ CREATE DATABASE AND USE

CREATE DATABASE IF NOT EXISTS shop;   -- Create database 'shop' if it doesn't exist
USE shop;                              -- Select the 'shop' database

-- 2️⃣ CREATE TABLE orders

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,   -- Order ID, auto increment, unique
    customer_name VARCHAR(100) NOT NULL,       -- Customer name, cannot be null
    order_date DATETIME NOT NULL,              -- Order datetime (date + time)
    amount DECIMAL(10,2) NOT NULL             -- Order amount
) ENGINE=InnoDB;                               -- InnoDB engine for future FK support

-- 3️⃣ INSERT SAMPLE DATA

INSERT INTO orders (customer_name, order_date, amount) VALUES
('Mamun', '2026-03-04 14:30:00', 100.00),  -- Order on 4th March 2:30 PM
('Rahim', '2026-03-04 16:15:00', 150.00), -- Order on 4th March 4:15 PM
('Karim', '2026-03-05 10:00:00', 200.00), -- Order on 5th March 10 AM
('Sumaiya', '2026-03-05 12:45:00', 50.00),-- Order on 5th March 12:45 PM
('Rina', '2026-03-06 09:15:00', 75.00),   -- Order on 6th March 9:15 AM
('Tania', '2026-03-06 14:00:00', 120.00); -- Order on 6th March 2 PM

-- 4️⃣ BASIC SELECT QUERIES

SELECT * FROM orders;                              -- Show all orders
SELECT DATE(order_date) AS order_day, *            -- Show only date part
       customer_name, amount
FROM orders;

SELECT DAYNAME(order_date) AS weekday, *           -- Show weekday (Monday, Tuesday...)
       customer_name, amount
FROM orders;

SELECT HOUR(order_date) AS order_hour, *           -- Show order hour (0-23)
       customer_name, amount
FROM orders;

SELECT order_id,
       customer_name,
       DATE(order_date) AS order_day,      -- Extract date
       DAYNAME(order_date) AS weekday,     -- Extract weekday
       HOUR(order_date) AS order_hour,     -- Extract hour
       amount
FROM orders;


-- 5️⃣ AGGREGATE FUNCTIONS + GROUP BY + ORDER BY + HAVING

-- Daily summary
SELECT DATE(order_date) AS order_day,
       COUNT(*) AS total_orders,       -- Total orders per day
       SUM(amount) AS total_amount,    -- Total amount per day
       AVG(amount) AS avg_amount,      -- Average order amount per day
       MIN(amount) AS min_amount,      -- Minimum order amount per day
       MAX(amount) AS max_amount       -- Maximum order amount per day
FROM orders
GROUP BY order_day
ORDER BY total_amount DESC;             -- Order by highest total amount first

-- Hourly + weekday summary
SELECT DATE(order_date) AS order_day,
       DAYNAME(order_date) AS weekday,
       HOUR(order_date) AS order_hour,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_amount
FROM orders
GROUP BY order_day, order_hour
HAVING total_orders >= 1                -- Show only groups with 1+ orders
ORDER BY order_day ASC, order_hour ASC;

-- 6️⃣ UPDATE / DELETE / TRUNCATE EXAMPLES

UPDATE orders
SET amount = amount + 10
WHERE customer_name LIKE 'Ma%';          -- Add 10 to all customers starting with 'Ma'

DELETE FROM orders
WHERE customer_name = 'Rahim';           -- Delete specific order

-- Remove all rows but keep table
-- TRUNCATE TABLE orders;

-- Drop table / database (optional)
-- DROP TABLE orders;
-- DROP DATABASE shop;