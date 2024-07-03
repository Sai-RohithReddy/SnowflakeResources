-- Derive Rank, Dense Rank and Row Number based on employee salary
SELECT employee_id, first_name, last_name, salary,
RANK() OVER(ORDER BY salary DESC) as RANK,
DENSE_RANK() OVER(ORDER BY salary DESC) as DEN_RNK,
ROW_NUMBER() OVER(ORDER BY salary DESC) as ROW_NUM
FROM hrdata.employees;

-- Dept wise top 3 salaries
SELECT * FROM
( SELECT dept_id, salary, first_name, last_name,
  DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY SALARY DESC) as rank
  FROM hrdata.employees
) WHERE RANK <= 3
ORDER BY dept_id, rank;

-----USE CASES---------

------SAMPLE DATA------
CREATE OR REPLACE TABLE STUDENTS 
(  ID INT NOT NULL,
   NAME VARCHAR(30) NOT NULL,
   DOB DATE,
   GENDER VARCHAR(1),
   MARKS DOUBLE,
 PRIMARY KEY(ID)
);

INSERT INTO STUDENTS VALUES
(1, 'Ramu', '2005-01-16', 'M', 88),
(2, 'Indra', '2006-07-18', 'M', 79),
(3, 'Lakshmi', '2005-12-15', 'F', 95),
(4, 'Varun', '2005-10-02', 'M', 85),
(5, 'Venkat', '2005-09-22', 'M', 96),
(6, 'Seetha', '2006-01-05', 'F', 82),
(7, 'Lakshman', '2005-06-24', 'M', 92),
(8, 'Ganga', '2005-11-12', 'F', 69),
(9, 'Lakshman', '2005-10-09', 'M', 87),
(10, 'Siva', '2005-08-31', 'M', 76),
(11, 'Krishna', '2006-02-27', 'M', 80),
(12, 'Balaji', '2005-07-10', 'M', 72),
(13, 'Sridevi', '2005-04-19', 'F', 91),
(14, 'Siva', '2005-11-26', 'M', 75),
(15, 'Ganesh', '2006-03-24', 'M', 95),
(16, 'Srinu', '2005-05-28', 'M', 90),
(17, 'Sarayu', '2005-02-05', 'F', 81),
(18, 'Karthik', '2005-12-03', 'M', 90),
(19, 'Parvathi', '2005-05-04', 'F', 66),
(20, 'Vishnu', '2005-08-17', 'M', 62),
(21, 'Padma', '2005-09-20', 'F', 76),
(22, 'Satya', '2005-08-15', 'F', 91),
(23, 'Srinu', '2005-05-28', 'M', 90);

-------------

-- Use Case 1. Find the names of students with top 3 marks
SELECT NAME, MARKS, RANK FROM
(SELECT *, DENSE_RANK() OVER(ORDER BY MARKS DESC) as RANK
FROM STUDENTS
) S 
WHERE RANK <=3 
ORDER BY RANK;

-- Use Case 2. Find Gender wise top 3 students 
SELECT GENDER, RANK, NAME, MARKS FROM
(SELECT *, DENSE_RANK() OVER(PARTITION BY GENDER ORDER BY MARKS DESC) as RANK
FROM STUDENTS
) S 
WHERE RANK <=3 
ORDER BY GENDER, RANK;

-- Use Case 3. Derive EAMCET rank based on the marks given
SELECT ID, NAME, DOB, MARKS, 
ROW_NUMBER() OVER(ORDER BY MARKS DESC, DOB, NAME) as EAMCET_RANK
FROM STUDENTS;