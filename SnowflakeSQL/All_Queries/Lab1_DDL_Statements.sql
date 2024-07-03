DDL Statements Practice
--------------------------
-- Create a DATABASE
CREATE DATABASE IF NOT EXISTS emp;


-- Creating Table
CREATE TABLE public.employee
   ( employee_id BIGINT
   , first_name VARCHAR(20)
   , last_name VARCHAR(25)
   , hire_date DATE
   , salary NUMBER(8,2) -- use DECIMAL(8,2) if NUMBER is not working
   , manager_id BIGINT
   , department_id INT
   ) ; 
   
-- Describe Table
DESC TABLE public.employee;
   
-- Renaming Table using ALTER
ALTER TABLE public.employee RENAME to public.employees;

-- Add a new column 'loaction'
ALTER TABLE public.employees ADD COLUMN location varchar(30);

-- Increase the length of first_name from 20 to 25
ALTER TABLE public.employees modify first_name VARCHAR(25);

-- Drop existing column manager_id
ALTER TABLE public.employees drop column manager_id;

-- Describe Table
DESC TABLE public.employee;

-- Drop the Table completely
DROP TABLE public.employees;