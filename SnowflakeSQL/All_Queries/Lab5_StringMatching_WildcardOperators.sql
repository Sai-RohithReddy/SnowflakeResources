Wildcard Operators
===================

-- List all employees whose first name starts with letter 'A'
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name LIKE 'A%';

-- SQL Data is case sensitive, upper case letter won't match with lower case letters.

-- List all employees whose first name doesn't starts with letter 'A'
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name NOT LIKE 'A%';

-- List all employees where 2nd character of first_name is 'a'
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name LIKE '_a%';

-- List all employees whose first_name ends with 'a'
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name LIKE '%a';

-- List all employees whose first_name starts with 'A' and ends with 'a'
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name LIKE 'A%a';

-- List all employees whose first name and last name starts with letter 'A'
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name LIKE 'A%' AND last_name LIKE 'A%';

-- List all employees whose first name starts 'A' and exactly have 5 characters
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name LIKE 'A____';

-- List all employees whose first name contains a space in it
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE first_name LIKE '% %';

-- List all employees whose last name has single character
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE last_name LIKE '_';

-- List all employees whose last name has 1 or 2 characters
SELECT employee_id, first_name, last_name FROM hrdata.employees
WHERE last_name LIKE '_' or last_name LIKE '__';