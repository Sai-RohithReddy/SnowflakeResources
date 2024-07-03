-- Sample data setup
CREATE OR REPLACE TABLE public.empl 
( empid INT, empname VARCHAR(50), age INT, gender CHAR(1), salary INT);

INSERT INTO public.empl VALUES
(111, 'Daniel', 34, 'M', 62000),
(112, 'Jessica', 28, 'F', 55000),
(113, 'Aryan', 29, 'D', 53000),
(114, 'Natasha', 31, 'T', 56000),
(115, 'Gracy', 26, 'G', 46000),
(116, 'July', 27, null, 47000),
(117, 'Stefen', 32, 'M', 58000);


-- Using Case statement to Derive full form of Gender
SELECT empid, empname, gender as gender_code,
CASE WHEN gender = 'F' THEN 'Female'
     WHEN gender = 'M' THEN 'Male'
     WHEN gender = 'T' THEN 'Transgender'
     WHEN gender = 'D' or gender is null THEN 'Don\'t want to disclose'
     ELSE 'Others' END as gender
FROM public.empl;


-- Using Decode statement to Derive full form of Gender
SELECT empid, empname, gender as gender_code,
DECODE(gender, 'M', 'Male', 'F', 'Female', 'T', 'Transgender', 
               'D', 'Don\'t want to disclose', null, 'Don\'t want to disclose', 'Others') as gender
FROM public.empl;


-- Use Case: Derive the tax amount of employees based on their yearly earnings
SELECT
employee_id, first_name, last_name, salary,
CASE WHEN salary*12 <= 100000 THEN 0
     WHEN salary*12 between 100001 AND 200000 THEN cast( (salary*10)/100 as NUMBER(10,2)) 
     WHEN salary*12 between 200001 AND 300000 THEN cast( (salary*20)/100 as NUMBER(10,2))
     ELSE cast( (salary*30)/100 as NUMBER(10,2)) 
     END as tax_amount
FROM hrdata.employees
ORDER BY salary DESC;
