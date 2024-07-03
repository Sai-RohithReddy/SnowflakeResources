WHERE 
======

-- Display only department 20 employees data
SELECT * FROM hrdata.employees WHERE dept_id=20;

-- Display emp id, first_name whose salary is greater than 10000
SELECT employee_id, first_name, salary FROM hrdata.employees
WHERE salary >= 10000;

-- Display whose yearly income is >= 200000
SELECT employee_id, first_name, salary as mon_sal, salary*12 as year_sal
FROM hrdata.employees WHERE salary*12 >= 200000;

-- List of employees who joined on or after 2000-01-01
SELECT employee_id, first_name, hire_date FROM hrdata.employees
WHERE hire_date >= TO_DATE('2000-01-01', 'YYYY-MM-DD');

-- List of employees whose salary is >= 5000 from department 50
SELECT employee_id, dept_id, first_name, salary FROM hrdata.employees
WHERE dept_id=50 AND salary >= 5000;

-- List of employees whose salary is >= 5000 from department 50 or whose salary >=6000 from dept 80
SELECT employee_id, dept_id, first_name, salary FROM hrdata.employees
WHERE (dept_id=50 AND salary >= 5000) OR (dept_id=80 AND salary >= 6000);


BETWEEN
========
-- List of employees whose salary in between 8000 and 10000
SELECT employee_id, first_name, salary FROM hrdata.employees
WHERE salary >= 8000 and salary <=10000

-- Using between operator
SELECT employee_id, first_name, salary FROM hrdata.employees
WHERE salary between 8000 and 10000;

-- Not between is just opposite to between
SELECT employee_id, first_name, salary FROM hrdata.employees
WHERE salary not between 8000 and 10000;


ORDER BY
=========
-- Sort the data based on emp first_name in ascending order
SELECT * FROM hrdata.employees ORDER BY first_name;

-- Sort the data based on emp salary in descending order
SELECT employee_id, first_name, salary FROM hrdata.employees ORDER BY salary desc;

-- Sort the data based on emp joining date in ascending order
SELECT employee_id, first_name, hire_date FROM hrdata.employees ORDER BY hire_date asc;

-- Sort the data based on dept and salary in descending order
SELECT dept_id, first_name, last_name, salary 
FROM hrdata.employees ORDER BY dept_id asc, salary desc;
