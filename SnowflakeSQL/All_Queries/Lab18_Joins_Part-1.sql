-- Inner Join
SELECT emp.employee_id, emp.first_name, emp.last_name, emp.salary, emp.dept_id, dept.dept_id, dept.department_name
FROM hrdata.employees emp 
INNER JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id ;

SELECT * FROM hrdata.employees;
SELECT * FROM hrdata.employees WHERE dept_id is NULL;

-- Left Outer Join
SELECT emp.employee_id, emp.first_name, emp.last_name, emp.salary, emp.dept_id, dept.dept_id, dept.department_name
FROM hrdata.employees emp 
LEFT OUTER JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id ;

SELECT emp.employee_id, emp.first_name, emp.last_name, emp.salary, job.employee_id, job.job_id, job.start_date, job.end_date
FROM hrdata.employees emp 
LEFT OUTER JOIN hrdata.job_history job
ON emp.employee_id = job.employee_id ;

SELECT * FROM hrdata.job_history;
SELECT DISTINCT employee_id FROM hrdata.job_history;

SELECT emp.employee_id, emp.first_name, emp.last_name, emp.salary, job.employee_id, job.job_id, job.start_date, job.end_date
FROM hrdata.employees emp 
INNER JOIN hrdata.job_history job
ON emp.employee_id = job.employee_id;

-- Right Outer Join
SELECT emp.employee_id, emp.first_name, emp.last_name, emp.salary, emp.dept_id, dept.dept_id, dept.department_name
FROM hrdata.employees emp 
RIGHT OUTER JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id ;

-- Full Outer Joion
SELECT emp.employee_id, emp.first_name, emp.last_name, emp.salary, emp.dept_id, dept.dept_id, dept.department_name
FROM hrdata.employees emp 
FULL OUTER JOIN hrdata.departments dept
ON emp.dept_id = dept.dept_id ;


-- Self Join
-- Get Manager Names of all employees
SELECT emp.employee_id, 
emp.first_name||' '||emp.last_name as emp_name,
emp.manager_id,
mgr.first_name||' '||mgr.last_name as mgr_name
FROM hrdata.employees emp
JOIN hrdata.employees mgr 
ON emp.manager_id = mgr.employee_id;

-- Get Manager Names of all employees working in Dept 60 and 90
SELECT emp.dept_id,
emp.employee_id, 
emp.first_name||' '||emp.last_name as emp_name,
emp.manager_id,
mgr.first_name||' '||mgr.last_name as mgr_name
FROM hrdata.employees emp
INNER JOIN hrdata.employees mgr
-- LEFT JOIN hrdata.employees mgr -- for left join use Where
ON emp.manager_id = mgr.employee_id
AND emp.dept_id in (60,90);
-- WHERE emp.dept_id in (60,90);
------------------------------------

-- Cross or Cartesian Join
SELECT c.*, r.* 
FROM hrdata.countries c
CROSS JOIN hrdata.regions r; -- 25*4 =100

select * from hrdata.countries; -- 25
select * from hrdata.regions; -- 4

(or)

SELECT c.*, r.* 
FROM hrdata.countries c, hrdata.regions r;
------------------------------------
