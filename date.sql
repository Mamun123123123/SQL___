-- 1️⃣ CREATE DATABASE AND USE

CREATE DATABASE IF NOT EXISTS shop;   -- Create database 'shop' if it doesn't exist
USE shop;                              -- Select the 'shop' database to work on


-- 2️⃣ CREATE TABLE orders

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,   -- Order ID, auto increment, unique identifier
    customer_name VARCHAR(100) NOT NULL,       -- Customer name, cannot be null
    order_date DATETIME NOT NULL,              -- Order datetime (date + time)
    amount DECIMAL(10,2) NOT NULL             -- Order amount in decimal
) ENGINE=InnoDB;                               -- InnoDB engine required for future foreign key support


-- 3️⃣ INSERT SAMPLE DATA

INSERT INTO orders (customer_name, order_date, amount) VALUES
('Mamun', '2026-03-04 14:30:00', 100.00),  -- Order on 4th March at 2:30 PM
('Rahim', '2026-03-04 16:15:00', 150.00), -- Order on 4th March at 4:15 PM
('Karim', '2026-03-05 10:00:00', 200.00), -- Order on 5th March at 10 AM
('Sumaiya', '2026-03-05 12:45:00', 50.00),-- Order on 5th March at 12:45 PM
('Rina', '2026-03-06 09:15:00', 75.00),   -- Order on 6th March at 9:15 AM
('Tania', '2026-03-06 14:00:00', 120.00); -- Order on 6th March at 2 PM


-- 4️⃣ SELECT QUERIES WITH DATE(), DAYNAME(), HOUR()

-- a) Show only date part of order
SELECT order_id, customer_name, DATE(order_date) AS order_day, amount
FROM orders; -- Output: YYYY-MM-DD only

-- b) Show weekday (Monday, Tuesday...) of order
SELECT order_id, customer_name, DAYNAME(order_date) AS weekday, amount
FROM orders; -- Output: Weekday name

-- c) Show order hour (0-23)
SELECT order_id, customer_name, HOUR(order_date) AS order_hour, amount
FROM orders; -- Output: Hour of the order

-- d) Combined: date + weekday + hour
SELECT order_id,
       customer_name,
       DATE(order_date) AS order_day,      -- Extract date
       DAYNAME(order_date) AS weekday,     -- Extract weekday
       HOUR(order_date) AS order_hour,     -- Extract hour
       amount
FROM orders;

-- e) Daily & hourly summary (aggregation)
SELECT DATE(order_date) AS order_day,       -- Group by date
       DAYNAME(order_date) AS weekday,      -- Weekday name
       HOUR(order_date) AS order_hour,      -- Group by hour
       COUNT(*) AS total_orders,            -- Count of orders
       SUM(amount) AS total_amount          -- Total amount per group
FROM orders
GROUP BY order_day, order_hour
ORDER BY order_day, order_hour;            -- Order results by date and hour


-- 5️⃣ OPTIONAL: DELETE / TRUNCATE / DROP TABLE

-- DELETE FROM orders WHERE customer_name = 'Mamun';  -- Delete specific order
-- TRUNCATE TABLE orders;                              -- Remove all rows, keep structure
-- DROP TABLE orders;                                  -- Drop table completely
-- DROP DATABASE shop;                                 -- Drop database completely