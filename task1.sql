-- 1️⃣ DATABASE CREATE

CREATE DATABASE IF NOT EXISTS school_demo;
USE school_demo;

-- 2️⃣ CREATE STUDENTS TABLE

CREATE TABLE students (
    st_id INT PRIMARY KEY AUTO_INCREMENT,
    st_name VARCHAR(50),
    dept VARCHAR(50)
);

-- 3️⃣ CREATE ORDERS TABLE

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    st_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (st_id) REFERENCES students(st_id)
);

-- 4️⃣ INSERT SAMPLE DATA

INSERT INTO students (st_name, dept) VALUES
('Mamun','CSE'),
('Rahim','EEE'),
('Karim','IT'),
('Salam','CSE');

INSERT INTO orders (st_id, amount, order_date) VALUES
(1, 100, '2026-03-01'),
(1, 200, '2026-03-02'),
(2, 150, '2026-03-01'),
(2, 300, '2026-03-03'),
(3, 50,  '2026-03-02'),
(4, 120, '2026-03-04');

-- 5️⃣ Problem 1: LEFT JOIN (all students + their orders)

SELECT 
    s.st_name, 
    s.dept, 
    o.amount, 
    o.order_date
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id;

-- 6️⃣ Problem 2: GROUP BY summary (student-wise total orders & amount)

SELECT 
    s.st_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id
GROUP BY s.st_id;

-- 7️⃣ Problem 3: WINDOW FUNCTION - student-wise total amount (row retain)

SELECT 
    s.st_name,
    o.amount,
    SUM(o.amount) OVER(PARTITION BY s.st_id) AS total_amount
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id;

-- 8️⃣ Problem 4: ROW_NUMBER() per student (order rank)

SELECT 
    s.st_name,
    o.amount,
    ROW_NUMBER() OVER(PARTITION BY s.st_id ORDER BY o.amount DESC) AS order_rank
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id;

-- 9️⃣ Problem 5: Running total over order_date

SELECT 
    o.order_id,
    o.st_id,
    o.amount,
    SUM(o.amount) OVER(ORDER BY o.order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM orders o;

-- 🔟 Problem 6: CREATE VIEW for student orders

CREATE VIEW student_order_view AS
SELECT 
    s.st_name,
    s.dept,
    o.amount,
    o.order_date
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id;

-- SELECT from view
SELECT * FROM student_order_view;

-- 1️⃣1️⃣ Problem 7: Top order per student using WINDOW

SELECT *
FROM (
    SELECT 
        s.st_name,
        o.amount,
        ROW_NUMBER() OVER(PARTITION BY s.st_id ORDER BY o.amount DESC) AS top_order_rank
    FROM students s
    LEFT JOIN orders o
    ON s.st_id = o.st_id
) t
WHERE top_order_rank = 1;

-- 1️⃣2️⃣ Problem 8: Department summary (total students, total orders, total amount)

SELECT 
    s.dept,
    COUNT(DISTINCT s.st_id) AS total_students,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id
GROUP BY s.dept;

-- 1️⃣3️⃣ Extra Challenge: Previous order amount per student (LAG)

SELECT 
    s.st_name,
    o.amount,
    LAG(o.amount) OVER(PARTITION BY s.st_id ORDER BY o.order_date) AS prev_amount
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id;