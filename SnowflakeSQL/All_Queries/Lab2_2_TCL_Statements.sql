TCL Commands 
=============
-- set autocommit to false(disable autocommit)
ALTER SESSION SET AUTOCOMMIT = FALSE;

INSERT INTO public.employees VALUES 
   ( 102,  'Lex',  'De Haan', '515.123.4569',  '1993-01-15', 17000, 90),
   ( 103,  'Alexander',  'Hunold', '590.423.4567',  '1990-01-04', 13000, 60);

COMMIT;

-- Have a look at the table
SELECT * FROM public.employees;

-- Delete all records from the table
DELETE FROM public.employees;

-- Have a look at the table
SELECT * FROM public.employees;

-- Rollback the transactions
ROLLBACK;

-- Have a look at the table
SELECT * FROM public.employees;
-----------------------------------

-- Delete all records from the table
DELETE FROM public.employees;

-- Have a look at the table
SELECT * FROM public.employees;

-- Commit the transactions
COMMIT;

-- Rollback the transactions
ROLLBACK;

-- Have a look at the table
SELECT * FROM public.employees;

---------------
INSERT INTO public.employees VALUES 
   ( 102,  'Lex',  'De Haan', '515.123.4569',  '1993-01-15', 17000, 90),
   ( 103,  'Alexander',  'Hunold', '590.423.4567',  '1990-01-04', 13000, 60);

COMMIT;

-- Have a look at the table
SELECT * FROM public.employees;

-- Truncate the table
TRUNCATE TABLE public.employees;

-- Have a look at the table
SELECT * FROM public.employees;

-- Rollback the transactions
ROLLBACK;

-- Have a look at the table
SELECT * FROM public.employees;