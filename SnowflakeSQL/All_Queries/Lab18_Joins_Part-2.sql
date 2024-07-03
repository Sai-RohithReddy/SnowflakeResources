-- Joins
-- Other way to Join table is by using Where condition
-- But this is not suggestable because of performance concern
SELECT c.*, r.* 
FROM hrdata.countries c
CROSS JOIN hrdata.regions r
WHERE c.region_id = r.region_id;

SELECT emp.employee_id, emp.first_name, emp.last_name, emp.salary, emp.dept_id, 
dept.dept_id, dept.department_name
FROM hrdata.employees emp, hrdata.departments dept
WHERE emp.dept_id = dept.dept_id;
------------------------------------

-- Joins with subqueries
-- Get department name and city, state information of employees
SELECT emp.employee_id, emp.first_name, emp.last_name,
dept_loc.department_name, dept_loc.city, dept_loc.state_province as state
FROM hrdata.employees emp
JOIN
( SELECT dept.dept_id, dept.department_name, loc.city, loc.state_province
  FROM hrdata.departments dept
  JOIN hrdata.locations loc
  ON dept.location_id = loc.location_id
) dept_loc
ON emp.dept_id = dept_loc.dept_id;

------------------------------------
-- Important for Interviews	-- Joins with nulls
create table public.table_A(ID int);
insert into public.table_A values(1),(2),(1), (3),(null);

create table public.table_B(ID int);
insert into public.table_B values(1),(2),(2),(4),(null),(null);

select A.ID, B.ID 
from public.table_A A inner join public.table_B B on A.ID = B.ID; -- 

select A.ID, B.ID 
from public.table_A A left join public.table_B B on A.ID = B.ID; -- 

select A.ID, B.ID 
from public.table_A A right join public.table_B B on A.ID = B.ID; -- 

select A.ID, B.ID 
from public.table_A A full join public.table_B B on A.ID = B.ID; -- 

select A.ID, B.ID 
from public.table_A A cross join public.table_B B; -- 


-- Multiple table joins
-- Use Case: Get all employee details(manager, dept, address, country, region, job, job history)
SELECT
emp.employee_id, emp.first_name||' '||emp.last_name as emp_name, emp.salary, 
emp.hire_date, emp.email, emp.phone_number, mgr.first_name||' '||mgr.last_name as mgr_name,
dept.department_name, loc.street_address, loc.postal_code, loc.city, loc.state_province as state,
cnt.country_name as country, reg.region_name as region,
job.job_title, jh.start_date, jh.end_date

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

LEFT OUTER JOIN hrdata.job_history jh
ON emp.employee_id = jh.employee_id
;

