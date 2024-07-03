NUMERIC FUNCTIONS
==================

SELECT abs(1.25), abs(-4.71), abs(-981), abs(0);
SELECT mod(25,4), mod(-39,5), mod(1234,7);
SELECT sqrt(225), square(12), power(5,4);
SELECT ceil(2.3), ceil(-4.8), ceil(0);
SELECT floor(2.3), floor(-4.8), floor(0);
SELECT round(2.3), round(2.8), round(2.5), round(-4.8);
SELECT sign(9), sign(-9), sign(0);
SELECT log(10,10),log(10,100), ln(10);
SELECT exp(2);
SELECT factorial(6);

-- Fetch all employee details with even number employee id
SELECT * FROM hrdata.employees WHERE mod(employee_id,2)=0;

-- Divide the input data into 4 sets
SELECT * FROM hrdata.employees WHERE mod(employee_id,4)=0;
SELECT * FROM hrdata.employees WHERE mod(employee_id,4)=1;
SELECT * FROM hrdata.employees WHERE mod(employee_id,4)=2;
SELECT * FROM hrdata.employees WHERE mod(employee_id,4)=3;
