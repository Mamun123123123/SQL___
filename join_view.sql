-- 1️⃣ CREATE DATABASE

CREATE DATABASE IF NOT EXISTS school;   -- Create database if not exists
USE school;                              -- Select database

-- 2️⃣ CREATE STUDENTS TABLE

CREATE TABLE students (
    st_id INT PRIMARY KEY AUTO_INCREMENT,  -- Student ID (Primary Key)
    st_name VARCHAR(100) NOT NULL,         -- Student Name (Required)
    dept VARCHAR(50) NOT NULL              -- Department
);

-- 3️⃣ CREATE ORDERS TABLE

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,  -- Order ID
    amount DECIMAL(10,2) NOT NULL,            -- Order Amount
    st_id INT,                                -- Foreign Key column
    FOREIGN KEY (st_id) REFERENCES students(st_id)  -- Relation with students table
);

-- 4️⃣ INSERT SAMPLE DATA INTO STUDENTS

INSERT INTO students (st_name, dept) VALUES
('Mamun', 'CSE'),
('Rahim', 'EEE'),
('Karim', 'IT');

-- 5️⃣ INSERT SAMPLE DATA INTO ORDERS

INSERT INTO orders (amount, st_id) VALUES
(100.00, 1),
(200.00, 1),
(150.00, 2);

-- 6️⃣ INNER JOIN EXAMPLE

-- Show only students who have orders
SELECT students.st_name,
       students.dept,
       orders.amount
FROM students
INNER JOIN orders
ON students.st_id = orders.st_id;

-- 7️⃣ LEFT JOIN EXAMPLE

-- Show all students (even if no order)
SELECT students.st_name,
       students.dept,
       orders.amount
FROM students
LEFT JOIN orders
ON students.st_id = orders.st_id;

-- 8️⃣ JOIN + GROUP BY (Summary)

-- Show total orders and total amount per student
SELECT students.st_name,
       COUNT(orders.order_id) AS total_orders,  -- Total orders per student
       SUM(orders.amount) AS total_amount       -- Total amount per student
FROM students
LEFT JOIN orders
ON students.st_id = orders.st_id
GROUP BY students.st_id;

-- 9️⃣ CREATE VIEW USING JOIN

-- Create a view to save join query
CREATE VIEW student_order_view AS
SELECT students.st_name,
       students.dept,
       orders.amount
FROM students
INNER JOIN orders
ON students.st_id = orders.st_id;

-- 🔟 USE VIEW

-- Now just select from view (no need to write join again)
SELECT * FROM student_order_view;


-- 1️⃣1️⃣ CREATE SUMMARY VIEW

CREATE VIEW student_summary_view AS
SELECT students.st_name,
       COUNT(orders.order_id) AS total_orders,
       SUM(orders.amount) AS total_amount
FROM students
LEFT JOIN orders
ON students.st_id = orders.st_id
GROUP BY students.st_id;

-- Use summary view
SELECT * FROM student_summary_view;


-- 1️⃣2️⃣ DROP VIEW (if needed)

-- DROP VIEW student_order_view;
-- DROP VIEW student_summary_view;