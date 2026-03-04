-- 1️⃣ DATABASE CREATE

CREATE DATABASE IF NOT EXISTS school_demo;
USE school_demo;

-- 2️⃣ CREATE STUDENTS TABLE

CREATE TABLE students (
    st_id INT PRIMARY KEY AUTO_INCREMENT,
    st_name VARCHAR(100) NOT NULL,
    dept VARCHAR(50) NOT NULL
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
('Karim','IT');

INSERT INTO orders (st_id, amount, order_date) VALUES
(1, 100, '2026-03-01'),
(1, 200, '2026-03-02'),
(2, 150, '2026-03-01'),
(2, 300, '2026-03-03'),
(3, 50,  '2026-03-02');

-- 5️⃣ SIMPLE INNER JOIN

SELECT s.st_name, s.dept, o.amount, o.order_date
FROM students s
INNER JOIN orders o
ON s.st_id = o.st_id;

-- 6️⃣ GROUP BY SUMMARY (Student-wise total & count)

SELECT s.st_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS total_amount
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id
GROUP BY s.st_id;

-- 7️⃣ WINDOW FUNCTION: TOTAL PER STUDENT

SELECT o.order_id,
       o.st_id,
       o.amount,
       SUM(o.amount) OVER(PARTITION BY o.st_id) AS student_total_amount
FROM orders o;

-- 8️⃣ WINDOW FUNCTION: ROW_NUMBER per Student

SELECT o.order_id,
       o.st_id,
       o.amount,
       ROW_NUMBER() OVER(PARTITION BY o.st_id ORDER BY o.amount DESC) AS order_rank
FROM orders o;

-- 9️⃣ WINDOW FUNCTION: RUNNING TOTAL

SELECT o.order_id,
       o.st_id,
       o.amount,
       SUM(o.amount) OVER(ORDER BY o.order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM orders o;

-- 🔟 CREATE VIEW: Student Orders

CREATE VIEW student_order_view AS
SELECT s.st_name,
       s.dept,
       o.amount,
       o.order_date
FROM students s
INNER JOIN orders o
ON s.st_id = o.st_id;

-- SELECT from view
SELECT * FROM student_order_view;

-- 1️⃣1️⃣ CREATE VIEW: Student Summary with GROUP BY

CREATE VIEW student_summary_view AS
SELECT s.st_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS total_amount
FROM students s
LEFT JOIN orders o
ON s.st_id = o.st_id
GROUP BY s.st_id;

SELECT * FROM student_summary_view;

-- 1️⃣2️⃣ TOP 1 ORDER PER STUDENT USING WINDOW FUNCTION

SELECT order_id, st_id, amount,
       ROW_NUMBER() OVER(PARTITION BY st_id ORDER BY amount DESC) AS top_order_rank
FROM orders
WHERE top_order_rank = 1;  -- NOTE: Some DBs may require this as a subquery