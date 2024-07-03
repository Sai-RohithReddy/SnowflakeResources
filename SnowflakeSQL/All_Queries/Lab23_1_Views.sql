-- Views

-- Creating Views 
CREATE VIEW hrdata.v_employees
AS
SELECT * FROM hrdata.employees;

SELECT * FROM hrdata.v_employees;

CREATE VIEW hrdata.v_employees2
AS
SELECT employee_id, first_name, last_name, salary FROM hrdata.employees;

SELECT * FROM hrdata.v_employees2;


-- Views with Filters, Joins and Aggregates

-- 1. Create a view with details of employees working in 'IT' department
CREATE VIEW hrdata.v_employees_it_dept
AS 
SELECT emp.*, dept.department_name
FROM hrdata.employees emp 
JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id
WHERE dept.department_name LIKE 'IT'
;

SELECT * FROM hrdata.v_employees_it_dept;

-- 2. Create a view with the details of employees working in 'Europe' region
CREATE VIEW hrdata.v_employees_europe
AS
SELECT emp.employee_id, emp.first_name, emp.salary, emp.hire_date, 
dept.department_name, cnt.country_name, reg.region_name
FROM hrdata.employees emp 
JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id
JOIN hrdata.locations loc
ON dept.location_id = loc.location_id
JOIN hrdata.countries cnt
ON loc.country_id = cnt.country_id
JOIN hrdata.regions reg
ON cnt.region_id = reg.region_id
WHERE reg.region_name = 'Europe'
;

SELECT * FROM hrdata.v_employees_europe;

-- 3. Create a view for top 3 salaried employees and their salaries
CREATE VIEW hrdata.v_top3_salaried_employees
AS
SELECT employee_id, first_name, last_name, salary FROM 
( SELECT *, DENSE_RANK() OVER(ORDER BY salary DESC) as rank
  FROM hrdata.employees
) WHERE rank <= 3
;

SELECT * FROM hrdata.v_top3_salaried_employees;

-- 4. Create a view with dept wise number of employees hired in the year 1997
CREATE VIEW hrdata.v_dept_wise_emp_hired
AS
SELECT dept.department_name, count(*) as no_emp_hired
FROM hrdata.employees emp 
JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id
WHERE YEAR(hire_date) = 1997
--WHERE YEAR(hire_date) = YEAR(CURRENT_DATE)
GROUP BY dept.department_name
;

SELECT * FROM hrdata.v_dept_wise_emp_hired;

-- 5. Create a view with the number of direct employees working under all managers
CREATE VIEW hrdata.v_direct_reportees_count
AS
SELECT emp.manager_id, mgr.first_name||' '||mgr.last_name as mgr_name, COUNT(*) as reportees_count
FROM hrdata.employees emp
JOIN hrdata.employees mgr
ON emp.manager_id = mgr.employee_id
GROUP BY emp.manager_id, mgr_name
;

SELECT * FROM hrdata.v_direct_reportees_count;

-- 6. Create a view with complete employee details.
CREATE VIEW hrdata.v_employee_details
AS
SELECT
emp.employee_id, emp.first_name||' '||emp.last_name as emp_name, emp.salary, 
emp.hire_date, emp.email, emp.phone_number, mgr.first_name||' '||mgr.last_name as mgr_name,
dept.department_name, loc.street_address, loc.postal_code, loc.city, loc.state_province as state,
cnt.country_name as country, reg.region_name as region, job.job_title

FROM hrdata.employees emp

LEFT OUTER JOIN hrdata.employees mgr
ON emp.manager_id = mgr.employee_id

LEFT OUTER JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id

LEFT OUTER JOIN hrdata.locations loc
ON dept.location_id = loc.location_id

LEFT OUTER JOIN hrdata.countries cnt
ON loc.country_id = cnt.country_id

LEFT OUTER JOIN hrdata.regions reg
ON cnt.region_id = reg.region_id

LEFT OUTER JOIN hrdata.jobs job
ON emp.job_id = job.job_id
;

SELECT * FROM hrdata.v_employee_details;
---------------------------------------------

-- Altering or modifying a view definition
-- Just use CREATE OR REPLACE VIEW syntax
CREATE OR REPLACE VIEW hrdata.v_dept_wise_emp_hired
AS
SELECT dept.department_name, count(*) as no_emp_hired
FROM hrdata.employees emp 
JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id
WHERE YEAR(hire_date) = 1999
--WHERE YEAR(hire_date) = YEAR(CURRENT_DATE)
GROUP BY dept.department_name
;

SELECT * FROM hrdata.v_dept_wise_emp_hired;

-- Dropping a View
DROP VIEW hrdata.v_employees_it_dept;
DROP VIEW hrdata.v_top3_salaried_employees;

-----------------
