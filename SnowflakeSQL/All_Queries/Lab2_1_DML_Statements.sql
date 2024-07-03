DML Statements Practice
========================

-- Create a table first
CREATE TABLE public.employees
   ( employee_id NUMBER(6)
   , first_name VARCHAR(20)
   , last_name VARCHAR(25)
   , phone_number VARCHAR(20)
   , dob DATE
   , salary NUMBER(8,2)
   , dept_id NUMBER(4)
 ) ; 

-- Insert Command 
 
-- Insert the data now 
INSERT INTO public.employees VALUES 
   ( 100, 'Steven', 'King', '515.123.4567', '1987-06-18', 24000, 90);
   
-- Insert data based on columns   
INSERT INTO public.employees(employee_id, first_name, last_name, dept_id, dob, salary)   
VALUES( 101, 'Neena', 'Kochhar', 90, '1989-09-22', 17000);

-- 
INSERT INTO public.employees VALUES 
   ( 102,  'Lex',  'De Haan', '515.123.4569',  '1993-01-15', 17000, 90),
   ( 103,  'Alexander',  'Hunold', '590.423.4567',  '1990-01-04', 13000, 60),
   ( 104,  'Bruce',  'Ernst', '590.423.4568',  '1991-05-21', 12500, 60),
   ( 105,  'David',  'Austin', '590.423.4569', '1997-03-25', 15000, 60),
   ( 106,  'Valli',  'Pataballa', '590.423.4560',  '1996-02-05', 16500, 60),
   ( 107,  'Diana',  'Lorentz', '590.423.5567', '1998-04-15', 18500, 60)
 ;
 
-- Have a look at the data
SELECT * FROM public.employees;

-- Create another table with few columns
CREATE TABLE public.employees2
   ( emp_id NUMBER(6)
   , first_name VARCHAR(20)
   , last_name VARCHAR(25)
   , sal NUMBER(8,2)
 ) ;
 
-- Insert data from one table to another table
INSERT INTO public.employees2(emp_id, first_name, last_name, sal) 
SELECT employee_id, first_name, last_name, salary FROM public.employees;

-- Have a look at employees2 table
SELECT * FROM public.employees2;

----------------------
-- Update Command

-- Update the dept_id from 60 to 70
UPDATE public.employees
SET dept_id=70 where dept_id=60;

-- Increase salry to every one by 5000
UPDATE public.employees
SET salary=salary+5000;

-- Update the phone number and salry of emp 105
UPDATE public.employees
SET phone_number='590.423.1234', salary=21000
WHERE employee_id=105;

-- Have a look at the data
SELECT * FROM public.employees;

---------------------
-- Delete Command

-- Remove all employees from dept 90
DELETE FROM public.employees WHERE dept_id=90;

-- Have a look at the data
SELECT * FROM public.employees;

-- Delete all records from emp table
DELETE FROM public.employees;

-- Have a look at employees table
SELECT * FROM public.employees;

-- Truncate emp table 
TRUNCATE TABLE public.employees2;

-- Have a look at employees2 table
SELECT * FROM public.employees2;

COMMIT;
