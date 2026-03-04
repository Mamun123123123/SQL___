-- 1️⃣ Create a new database called 'students'
CREATE DATABASE students;

-- 2️⃣ Select the database to use
USE students;

-- 3️⃣ Optional: Drop the database (সব data মুছে যাবে), সাধারণত practice বা reset এর জন্য
-- DROP DATABASE students;

-- 4️⃣ Create 'student' table with proper columns
CREATE TABLE student (
    st_id INT PRIMARY KEY AUTO_INCREMENT,      -- Student ID, auto increment
    st_name VARCHAR(100) NOT NULL,             -- Student name, cannot be null
    dept ENUM('cse','EEE','IT'),               -- Department, only allowed values
    email VARCHAR(25) NOT NULL,                -- Email, cannot be null
    admission_date DATE NOT NULL,              -- Admission date (avoid using 'date' as column name)
    phone VARCHAR(15),                          -- Phone number
    description TEXT,                           -- Optional description
    fee DECIMAL(10,2) NOT NULL,                -- Fee, decimal
    user_id INT,                                -- Foreign key to users table
    FOREIGN KEY(user_id) REFERENCES users(u_id) -- Link to users table, ensure users table exists
) ENGINE=InnoDB;                               -- InnoDB required for foreign key

-- 5️⃣ Insert sample data into 'student'
INSERT INTO student (st_name, dept, email, admission_date, phone, description, fee, user_id)
VALUES ('Mamun','cse','a@gmail.com','2026-12-12','0186666..','I am a student',20.00,2);

-- 6️⃣ Empty all rows from the table
TRUNCATE TABLE student; -- All data removed, table structure remains

-- 7️⃣ Delete specific row (if exists)
DELETE FROM student WHERE st_name = 'Mamun'; -- Remove student named Mamun

-- 8️⃣ Drop the table completely
DROP TABLE student; -- Table and all data removed

-- 9️⃣ Select query to find students in 'cse' department
SELECT * FROM student WHERE dept = 'cse';

-- 10️⃣ Create index on 'dept' column for faster search
CREATE INDEX dept_name ON student(dept);

-- 11️⃣ Count total number of students
SELECT COUNT(*) FROM student;
