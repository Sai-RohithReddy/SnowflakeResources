STRING FUNCTIONS
=================

-- length
SELECT employee_id, len(employee_id), first_name, length(first_name), last_name, length(last_name) FROM hrdata.employees;

-- derive the full name of employees
SELECT first_name, last_name, concat(first_name,' ',last_name) as full_name FROM hrdata.employees;
SELECT first_name, last_name, first_name || ' ' || last_name as full_name FROM hrdata.employees;
SELECT first_name, last_name, concat(first_name,'_',last_name) as full_name FROM hrdata.employees;

-- trim
SELECT trim('  I am learning sql   ');
SELECT len('  I am learning sql   '), len(trim('  I am learning sql  '));

-- ltrim, rtrim
SELECT ltrim('  I am learning sql   '), rtrim('  I am learning sql   ');
SELECT len(ltrim('  I am learning sql   ')), len(rtrim('  I am learning sql   '));

SELECT rtrim(ltrim('  I am learning sql   '));

-- trim leading and trailing special characters from a string
SELECT trim('#123#675#912##', '#');

-- remove leading 0s from the column
SELECT ltrim('000235', 0);

-- lpad and rpad
SELECT lpad(employee_id, 5, '0'), lpad(first_name, 10, '#'), rpad(last_name, 10, '*') FROM hrdata.employees;
SELECT lpad(first_name, 10, '*#&') FROM hrdata.employees;

-- substr(substring)
SELECT substr('I am learning SQL', 1, 6);
SELECT substr('I am learning SQL', 3, 8);

-- fetch first 5 characters from first name
SELECT first_name, substr(first_name, 1, 5) as fname FROM hrdata.employees;

-- fetch last 5 characters from last name
SELECT last_name, substr(last_name, length(last_name)-5+1, 5) as lname FROM hrdata.employees;
SELECT last_name, CASE WHEN length(last_name) < 5 THEN last_name ELSE substr(last_name,  length(last_name)-5+1, 5) END as lname FROM hrdata.employees;

-- reverse
SELECT reverse('Hyderabad'), reverse('what is your name');

-- lower, upper, initcap
SELECT lower('I am learning SQL'), upper('I am learning SQL'), initcap('I am learning SQL');

-- replace all 'a' with 'b'
SELECT replace('I am learning SQL', 'a', 'b');

-- remove all spaces from a string
SELECT replace('I Am Learning SQL', ' ', '');
