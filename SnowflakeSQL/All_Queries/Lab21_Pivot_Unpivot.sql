-- Pivot -- Rows to Columns
CREATE TABLE public.emp_sales(empid INT, amount INT, month VARCHAR(3));

INSERT INTO public.emp_sales VALUES
(1, 10000, 'JAN'),
(1, 400, 'JAN'),
(2, 4500, 'JAN'),
(2, 35000, 'JAN'),
(1, 5000, 'FEB'),
(1, 3000, 'FEB'),
(2, 200, 'FEB'),
(2, 90500, 'FEB'),
(1, 6000, 'MAR'),
(1, 5000, 'MAR'),
(2, 2500, 'MAR'),
(2, 9500, 'MAR');

-- Get empl wise total sales amount for each month
SELECT * FROM public.emp_sales
PIVOT (SUM(amount) FOR month IN ('JAN', 'FEB', 'MAR')) as p
ORDER BY empid;

------------------------------
--Unpivot -- Columns to Rows

CREATE OR REPLACE TABLE public.dept_sales
(empid INT, dept VARCHAR(20), jan VARCHAR(3),  feb VARCHAR(3), mar VARCHAR(3));

INSERT INTO public.dept_sales VALUES
(1, 'electronics', 100, 200, 300),
(2, 'clothes', 100, 300, 150),
(3, 'cars', 200, 400, 100);

-- Get dept wise sale details for every month
SELECT * FROM public.dept_sales
UNPIVOT (sales FOR month IN (jan, feb, mar))
ORDER BY empid;
