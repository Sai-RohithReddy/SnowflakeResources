SELECT
=======

-- Display all columns and all records from table
SELECT * FROM hrdata.employees;

-- Display only first_name, salary
SELECT first_name, salary FROM hrdata.employees;

-- Calculate yearly salary for all employees 
SELECT employee_id, first_name, salary as mon_sal, salary*12 as year_sal
FROM hrdata.employees;

-- Derive full name of employees
SELECT first_name, last_name, first_name||last_name as full_name
FROM hrdata.employees;

SELECT first_name, last_name, first_name||' '||last_name as full_name
FROM hrdata.employees;

-- Perform arithmatic operations
SELECT 20+48, 278*349, -146-24;

-- Call Predefined functions
SELECT sqrt(625), power(4,3), mod(92,10);   

-- Other Databases try with DUAL or DUMMY
SELECT 20+48, 278*349, -146-24, sqrt(625), power(4,3), mod(92,10) FROM dual;
(or) 
SELECT 20+48, 278*349, -146-24, sqrt(625), power(4,3), mod(92,10) FROM dummy;
