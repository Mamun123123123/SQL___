-- 1️⃣ CREATE DATABASE AND USE

CREATE DATABASE IF NOT EXISTS students;  -- Create database if not exists
USE students;                             -- Select the database

-- 2️⃣ CREATE TABLE student

CREATE TABLE IF NOT EXISTS student (
    st_id INT PRIMARY KEY AUTO_INCREMENT,        -- Student ID, auto increment
    st_name VARCHAR(100) NOT NULL,               -- Student name, cannot be null
    dept ENUM('cse','EEE','IT'),                 -- Department, only allowed values
    email VARCHAR(50) NOT NULL,                  -- Email, cannot be null
    admission_date DATE NOT NULL,                -- Admission date
    phone VARCHAR(15),                            -- Phone number
    description TEXT,                             -- Optional description
    fee DECIMAL(10,2) NOT NULL,                  -- Fee, decimal
    user_id INT,                                  -- Foreign key reference to users table
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES users(u_id) ON DELETE CASCADE ON UPDATE CASCADE,  -- Foreign key
    CONSTRAINT chk_fee CHECK (fee > 0)           -- Fee must be greater than 0
) ENGINE=InnoDB;                                 -- InnoDB required for foreign key

-- 3️⃣ INSERT DATA

INSERT INTO student (st_name, dept, email, admission_date, phone, description, fee, user_id)
VALUES 
('Mamun', 'cse', 'mamun@gmail.com', '2026-12-12', '01866660000', 'I am a student', 20.00, 2),
('Rahim', 'EEE', 'rahim@gmail.com', '2026-12-10', '01866661111', 'Top student', 50.00, 1);


-- 4️⃣ SELECT QUERIES

SELECT * FROM student;                      -- Show all students
SELECT * FROM student WHERE dept = 'cse';   -- Students in CSE department
SELECT COUNT(*) FROM student;               -- Count total students

-- 5️⃣ UPDATE QUERIES

UPDATE student
SET fee = 25.00
WHERE st_id = 1;                             -- Update single row

UPDATE student
SET fee = fee + 10
WHERE st_name LIKE 'Ma%';                    -- Update using pattern

UPDATE student
SET dept = 'CSE'
WHERE dept = 'IT';                           -- Update multiple rows


-- 6️⃣ ALTER TABLE (ADD / DROP / MODIFY)

ALTER TABLE student
ADD COLUMN extra_info VARCHAR(100);          -- Add new column

ALTER TABLE student
MODIFY st_name VARCHAR(150) NOT NULL;        -- Modify column size

-- Example: update CHECK constraint (drop + add)
ALTER TABLE student
DROP CHECK chk_fee;

ALTER TABLE student
ADD CONSTRAINT chk_fee CHECK (fee >= 10);    -- New fee constraint

-- 7️⃣ CREATE INDEX

CREATE INDEX idx_dept_name ON student(dept); -- Speed up dept search

-- 8️⃣ DELETE / TRUNCATE / DROP TABLE
DELETE FROM student WHERE st_name = 'Mamun';  -- Delete specific row
TRUNCATE TABLE student;                        -- Remove all rows
-- DROP TABLE student;                         -- Drop table completely (optional)
-- DROP DATABASE students;                     -- Drop database completely (optional)