-- Indexes
 
-- There is no concept of Indexes in Snowflake
-- So, Practice this on PostgreSQL or Online SQL Editors as Snowflake doesn't support Indexes
-- https://www.programiz.com/sql/online-compiler/

-- Set up test data
CREATE TABLE students
(sid INTEGER, 
 sname VARCHAR(30),
 subject VARCHAR(10),
 marks INTEGER, 
 birthdate DATE
 );
 
INSERT INTO students VALUES 
(501, 'Siddarth', 'Maths', 95, '2006-02-25'),
(501, 'Siddarth', 'Physics', 91, '2006-02-25'),
(501, 'Siddarth', 'Chemistry', 90, '2006-02-25'),
(505, 'Anitha', 'Maths', 91, '2006-03-08'),
(505, 'Anitha', 'Physics', 88, '2006-03-08'),
(505, 'Anitha', 'Chemistry', 84, '2006-03-08'),
(508, 'Varun', 'Maths', 82, '2004-04-15'),
(508, 'Varun', 'Physics', 77, '2004-04-15'),
(508, 'Varun', 'Chemistry', 86, '2004-04-15');

-- Create Index
CREATE INDEX idx_sid on students(sid);

-- Create Unique Index
CREATE UNIQUE INDEX uniq_idx_stud ON students(sid, subject);

-- Try inserting duplicate record
INSERT INTO students VALUES
(505, 'Anitha', 'Maths', 91, '2006-03-08');

-- Drop Indexes
DROP INDEX idx_sid;

DROP INDEX uniq_idx_stud;

-- Retry inserting duplicate record
INSERT INTO public.students VALUES
(505, 'Anitha', 'Maths', 91, '2006-03-08');

SELECT * FROM students ORDER BY sid;