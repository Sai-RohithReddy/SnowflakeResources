-- CTEs

-- Sample data setup - Creating 3 tables with students marks
CREATE TABLE public.students_maths
(sid INTEGER, 
 sname VARCHAR(30), 
 marks INTEGER, 
 birthdate DATE,
 primary key (sid)
);

INSERT INTO public.students_maths VALUES 
(501, 'Siddarth', 95, '2006-02-25'),
(505, 'Anitha', 91, '2006-03-08'),
(508, 'Varun', 82, '2004-04-15'),
(513, 'Divya', 73, '2005-01-24'),
(525, 'Pavani', 85, '2005-12-16'),
(515, 'Amar', 99, '2004-11-19'),
(524, 'Roopa', 81, '2006-03-04'),
(527, 'Sandeep', 69, '2005-10-29'),
(520, 'Suresh', 78, '2005-05-12'),
(504, 'Sandeep', 80, '2006-06-01');

CREATE TABLE public.students_physics
(rollno INTEGER,
 name VARCHAR(40),
 marks INTEGER,
 dob VARCHAR,
 primary key (rollno)
);

INSERT INTO public.students_physics VALUES 
(501, 'Siddarth', 91, '20060225'),
(505, 'Anitha', 88, '20060308'),
(508, 'Varun', 77, '20040415'),
(513, 'Divya', 79, '20050124'),
(525, 'Pavani', 82, '20051216'),
(515, 'Amar', 95, '20041119'),
(526, 'Siri', 85, '20060421'),
(527, 'Sandeep', 73, '20051029'),
(520, 'Suresh', 75, '20050512'),
(509, 'Amala', 84, '20051227');

CREATE TABLE public.students_chemistry
(stud_no INTEGER,
 stud_name VARCHAR(30),
 gender VARCHAR(1),
 stud_marks INTEGER,
 stud_dob DATE,
 primary key (stud_no)
);

INSERT INTO public.students_chemistry VALUES 
(501, 'Siddarth', 'M', 90, '2006-02-25'),
(505, 'Anitha', 'F', 84, '2006-03-08'),
(508, 'Varun', 'M', 86, '2004-04-15'),
(513, 'Divya', 'F', 79, '2005-01-24'),
(522, 'Mahesh', 'M', 82, '2005-11-26'),
(515, 'Amar', 'M', 93, '2004-11-19'),
(526, 'Siri', 'F', 78, '2006-04-21'),
(527, 'Sandeep', 'M', 71, '2005-10-29'),
(520, 'Suresh', 'M', 68, '2005-05-12'),
(509, 'Amala', 'F', 81, '2005-12-27');

-------------------
-- Use Case 1: Assign ranks to students who attended all 3 exams based on total marks

WITH 
all3 as
( SELECT sid as student_id FROM public.students_maths
  INTERSECT
  SELECT rollno as student_id FROM public.students_physics
  INTERSECT
  SELECT stud_no as student_id FROM public.students_chemistry
),

all_stud as 
( SELECT sid as student_id, sname as student_name, 'Maths' as subject, marks 
  FROM public.students_maths
  UNION
  SELECT rollno, name, 'Physics' as subject, marks FROM public.students_physics
  UNION 
  SELECT stud_no, stud_name, 'Chemistry' as subject, stud_marks 
  FROM public.students_chemistry
),

tot_marks as
( SELECT student_id, student_name, SUM(marks) as total_marks
  FROM all_stud 
  WHERE student_id in (SELECT student_id FROM all3)
  GROUP BY student_id, student_name
)

SELECT student_id, student_name, total_marks,
DENSE_RANK() OVER(ORDER BY TOTAL_MARKS desc) as RANK
FROM tot_marks
ORDER BY RANK;

-----------------------

-- Use Case 2: Get the list of employees whose Salary is more than the average salary of thier department

WITH dept_avg as
( SELECT dept_id, cast(AVG(salary) as NUMBER(10,2)) as dept_avg_sal FROM hrdata.employees
  GROUP BY dept_id
)
SELECT emp.employee_id, emp.first_name, emp.dept_id, emp.salary, da.dept_avg_sal
FROM hrdata.employees emp 
JOIN dept_avg da 
ON emp.dept_id = da.dept_id
AND emp.salary > da.dept_avg_sal
;

-----------------------

-- Use Case 3: Get all employee details(salary, mail, phone, dept, location, country, region, job title) with job title as 'Programmer'

WITH 
emp_job as
( SELECT emp.*, job.job_title 
  FROM hrdata.employees emp
  LEFT OUTER JOIN hrdata.jobs job
  ON emp.job_id = job.job_id
  WHERE UPPER(job.job_title) = 'PROGRAMMER'
),

address as 
( SELECT dept.*, loc.street_address, loc.postal_code, loc.city, loc.state_province as state,
         cnt.country_name as country, reg.region_name as region
		 
  FROM hrdata.departments dept
    
  LEFT OUTER JOIN hrdata.locations loc
  ON dept.location_id = loc.location_id
  
  LEFT OUTER JOIN hrdata.countries cnt
  ON loc.country_id = cnt.country_id
  
  LEFT OUTER JOIN hrdata.regions reg
  ON cnt.region_id = reg.region_id
)

SELECT ej.employee_id, ej.first_name||' '||ej.last_name as emp_name, 
	   ej.salary, ej.email, ej.phone_number, ej.hire_date, ej.job_title,
	   adr.department_name, adr.street_address, adr.postal_code, adr.city, adr.state,
       adr.country, adr.region
FROM emp_job ej 
LEFT JOIN address adr
ON ej.dept_id = adr.dept_id
;

--------------------
-- DML with CTEs

CREATE TABLE item_sales
(sale_id INTEGER, sale_item VARCHAR(30), price FLOAT, sale_date DATE);

INSERT INTO item_sales VALUES 
(111, 'Laptop', 52000, '2023-06-13'),
(111, 'Headset', 3500, null),
(111, 'Wireless Mouse', 1200, '2023-06-02'),
(111, 'Monitor', 15200, '2023-06-05'),
(111, 'Wireless Keypad', 1100, null),
(111, 'Sound Bar', 8400, null),
(111, 'Adapter', 3800, '2023-06-15'),
(111, 'Router', 4500, null);

SELECT * FROM item_sales;

-- Update sale date as 1st of the current month if it is null.

-- Other databases and Online sql editors 
-- https://www.programiz.com/sql/online-compiler/

WITH sd as
( SELECT SUBSTRING(CURRENT_DATE, 1,8)||'01' def_sale_date
)

UPDATE item_sales SET sale_date=sd.def_sale_date
FROM sd WHERE sale_date is NULL;

-- Snowflake
UPDATE item_sales SET sale_date=sd.def_sale_date
FROM
(
 SELECT YEAR(CURRENT_DATE)||'-'||MONTH(CURRENT_DATE)||'-01' as def_sale_date
) sd
WHERE sale_date is NULL;
