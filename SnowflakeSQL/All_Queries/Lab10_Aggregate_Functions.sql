-- Simple Aggregate Functions
SELECT COUNT(*) FROM hrdata.employees; -- 107
SELECT SUM(salary), AVG(salary) FROM hrdata.employees;
SELECT ROUND(SUM(salary)),cast(AVG(salary) as NUMBER(10,2)) as AVG_SAL FROM hrdata.employees;
SELECT MIN(salary), MAX(salary) FROM hrdata.employees;
SELECT MODE(salary), MEDIAN(salary) FROM hrdata.employees;


-- GROUP BY 
-- Dept wise employee count 
SELECT dept_id, COUNT(*) FROM hrdata.employees GROUP BY dept_id;

-- Dept wise Sum and Average Salaries
SELECT dept_id, SUM(salary), cast(AVG(salary) as NUMBER(10,2)) AVG_SAL FROM hrdata.employees GROUP BY dept_id;

-- Dept wise highest salary 
SELECT dept_id, MAX(salary) FROM hrdata.employees GROUP BY dept_id;

-- Get count of employees hired Year wise
SELECT YEAR(hire_date), count(*) FROM hrdata.employees GROUP BY YEAR(hire_date);

-- Get count of employees hired in each year Dept wise
SELECT YEAR(hire_date), dept_id, count(*) FROM hrdata.employees 
GROUP BY YEAR(hire_date), dept_id;

SELECT YEAR(hire_date), dept_id, count(*) FROM hrdata.employees 
GROUP BY YEAR(hire_date), dept_id
ORDER BY YEAR(hire_date), dept_id;

SELECT dept_id, YEAR(hire_date), count(*) FROM hrdata.employees 
GROUP BY YEAR(hire_date), dept_id
ORDER BY dept_id, YEAR(hire_date);


-- HAVING 
-- Dept wise employee count that has minimum of 10 employees
SELECT dept_id, COUNT(*) FROM hrdata.employees GROUP BY dept_id HAVING COUNT(*) >= 10;

-- Depts that has average salary of 10000 and more
SELECT dept_id, cast(AVG(salary)  as NUMBER(10,2)) AVG_SAL FROM hrdata.employees 
GROUP BY dept_id HAVING AVG(salary) >= 10000;


-- WHERE and GROUP BY 
-- Dept wise employee count who are earning greater than 100000 yearly
SELECT dept_id, COUNT(*) FROM hrdata.employees 
WHERE salary*12 >= 100000  GROUP BY dept_id;

SELECT dept_id, employee_id, salary FROM hrdata.employees WHERE dept_id = 100;


-- WHERE, GROUP BY and HAVING 
-- List of Depts that hired at least 10 employees after Year 1995
SELECT dept_id, COUNT(*) FROM hrdata.employees 
WHERE YEAR(hire_date) > 1995
GROUP BY dept_id  HAVING COUNT(*) > 10;
