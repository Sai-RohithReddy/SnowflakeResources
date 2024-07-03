-- Subqueries in filter conditions(Where)

-- Find the name of employee who is getting highest salary
SELECT employee_id, first_name, last_name, salary FROM hrdata.employees
WHERE salary = (SELECT MAX(salary) FROM hrdata.employees);

-- Find the number of employees in Finance dept
SELECT COUNT(*) FROM hrdata.employees
WHERE dept_id = 
(SELECT dept_id FROM hrdata.departments WHERE UPPER(department_name) = 'FINANCE');


-- Subqueries with 'IN' 
-- Find the total number of employees working in depts 10, 20 and 30
SELECT COUNT(*) FROM hrdata.employees WHERE dept_id in (10,20,30);

-- Find the total number of emp working in depts Admin, Marketing and Purchasing
SELECT COUNT(*) FROM hrdata.employees WHERE dept_id in 
( SELECT dept_id FROM hrdata.departments WHERE UPPER(department_name) in ('ADMINISTRATION','PURCHASING','MARKETING')
);


-- Nested Subqueries
-- Find the number of employees working from Seattle location
SELECT COUNT(*) FROM hrdata.employees
WHERE dept_id in 
( SELECT dept_id FROM hrdata.departments 
  WHERE location_id = 
  ( SELECT location_id FROM hrdata.locations WHERE UPPER(city) = 'SEATTLE')
);


-- Subqueries with EXISTS and NOT EXISTS 
-- Correlated Subqueries
-- Find the total number of employees who are working in 'IT' and 'Sales' depts 
SELECT COUNT(*) FROM hrdata.employees e
WHERE EXISTS 
( SELECT * FROM hrdata.departments d 
  WHERE e.dept_id = d.dept_id and d.department_name in ('IT','Sales')
); -- 38


-- Find the total number of employees who are not working in 'IT' and 'Sales' depts 
SELECT COUNT(*) FROM hrdata.employees e
WHERE NOT EXISTS 
( SELECT * FROM hrdata.departments d 
  WHERE e.dept_id = d.dept_id and d.department_name in ('IT','Sales')
); -- 69

-- Verify above counts
SELECT COUNT(1) FROM hrdata.employees; -- 107 = 38+69

----------
-- Subqueries with Joins - Will discuss at the time of Joins
