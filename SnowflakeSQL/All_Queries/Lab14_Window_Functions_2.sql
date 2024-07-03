-- Window Functions

-- Set up sample data -- Year wise sales details done by employees
CREATE OR REPLACE TABLE public.sales(emp_id INT, year INT, revenue NUMBER(10,2));

INSERT INTO public.sales VALUES 
(1, 2010, 1000), (1, 2011, 1500), (1, 2012, 500), (1, 2013, 750),
(2, 2010, 10000), (2, 2011, 12500), (2, 2012, 15000), (2, 2013, 20000),
(3, 2011, 800), (3, 2012, 1200), (3, 2013, 1100);

---------------

-- LAG and LEAD
-- Difference in sales with prev year
SELECT emp_id, year, revenue, LAG(revenue, 1, 0) OVER (PARTITION BY emp_id ORDER BY year) as rev_prev,
    revenue - rev_prev AS diff_in_rev 
FROM public.sales 
ORDER BY emp_id, year;

(or)

SELECT emp_id, year, revenue, LAG(revenue, 1, 0) OVER (PARTITION BY emp_id ORDER BY year) as rev_prev,
    revenue - LAG(revenue, 1, 0) OVER (PARTITION BY emp_id ORDER BY year) AS diff_in_rev 
FROM public.sales 
ORDER BY emp_id, year;

-- Difference in sales with next year
SELECT emp_id, year, revenue, LEAD(revenue, 1, 0) OVER (PARTITION BY emp_id ORDER BY year) as rev_next,
    revenue - LEAD(revenue, 1, 0) OVER (PARTITION BY emp_id ORDER BY year) AS diff_in_rev 
FROM public.sales 
ORDER BY emp_id, year;

(or)

SELECT emp_id, year, revenue, LEAD(revenue, 1, 0) OVER (PARTITION BY emp_id ORDER BY year) as rev_next,
   revenue - rev_next AS diff_in_rev 
FROM public.sales 
ORDER BY emp_id, year;

----------------------------

-- FIRST_VALUE, LAST_VALUE and NTH_VALUE
-- Get the top salary and least salary in each row
SELECT employee_id, first_name, salary, 
FIRST_VALUE(salary) OVER(ORDER BY salary desc) as top_sal,
LAST_VALUE(salary) OVER(ORDER BY salary desc) as least_sal
FROM hrdata.employees
order by salary desc;

-- Get dept wise top salary and least salary in each row
SELECT dept_id, employee_id, first_name, salary, 
FIRST_VALUE(salary) OVER(PARTITION BY dept_id ORDER BY salary desc) as top_sal_of_dept,
LAST_VALUE(salary) OVER(PARTITION BY dept_id ORDER BY salary desc) as least_sal_of_dept
FROM hrdata.employees
order by dept_id, salary desc;

-- Get dept wise 3rd gighest salary in each row
SELECT dept_id, employee_id, first_name, salary, 
NTH_VALUE(salary,3) OVER(PARTITION BY dept_id ORDER BY salary desc) as nth_sal_of_dept
FROM hrdata.employees
order by dept_id, salary desc;

-------------------

--Use Case: Calculate the change percentage of employees hired in each year

SELECT 
hire_year
,emp_hired
,LAG(emp_hired,1) OVER(ORDER BY hire_year) as emp_hired_prev_year
,round(((emp_hired - emp_hired_prev_year) * 100 ) / emp_hired_prev_year) as emp_hired_change_per
FROM
( SELECT YEAR(hire_date) as hire_year, COUNT(1) as emp_hired FROM hrdata.employees
  GROUP BY YEAR(hire_date)
) emp;