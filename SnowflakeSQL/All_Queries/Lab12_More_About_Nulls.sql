CREATE TABLE PUBLIC.EMPLOY 
( EMPID INT NOT NULL,
  FIRST_NAME VARCHAR(30) NOT NULL,
  LAST_NAME VARCHAR(30),
  AGE INT NULL,
  SALARY DOUBLE,
  LOCATION VARCHAR(20),
  DEPTID INT NOT NULL,
  PRIMARY KEY(EMPID)
);

INSERT INTO PUBLIC.EMPLOY VALUES
(1, 'Anitha', 'Rao', 28, 60000, 'Hyderabad', 101),
(2, 'Vinay', 'Kumar', 31, 70000, '', 102),
(3, 'Divya', null, 26, 50000, 'Hyderabad', 102),
(4, 'Rama', 'Devi', 28, null, 'Bangalore', 101),
(5, 'Naresh', 'Raju', 30, 65000, ' ', 103),
(6, 'Uma', 'Shankar', null, 55000, 'Chennai', null); -- change null to 102

SELECT * FROM PUBLIC.EMPLOY;

======================

-- 1. How to find Null or Blank?
-- By using IS NULL
select * from PUBLIC.EMPLOY where last_name is null;
select * from PUBLIC.EMPLOY where salary is null;
select * from PUBLIC.EMPLOY where location is null;

-- 2. Length of Null:
-- Length of a null value is null where length of a blank value is 0
select location, length(location) from PUBLIC.EMPLOY;
select first_name, last_name, length(last_name) from PUBLIC.EMPLOY;
select first_name, salary, length(salary) from PUBLIC.EMPLOY;
	
=======================

-- 3. Concatenation with nulls:
-- We can’t concatenate strings and nulls, if we do entire result will become null.
select first_name, last_name, first_name||last_name as full_name from PUBLIC.EMPLOY;
select  'RAM'||null as name;
select  'RAM'||'' as name;

-- 4. IFNULL:
-- How to handle nulls in above case, Answer is with IFNULL.
select first_name, last_name, first_name||ifnull(last_name,'') as full_name from PUBLIC.EMPLOY;
select first_name, IFNULL(last_name,'NA') from PUBLIC.EMPLOY;

==================

-- 5. Aggregate functions with Nulls
-- Null is neither maximum nor minimum
select max(salary) from PUBLIC.EMPLOY;
select min(salary) from PUBLIC.EMPLOY;
select min(ifnull(salary,0)) from PUBLIC.EMPLOY;

-- Count(col) function will not consider null values.
select count(*) from PUBLIC.EMPLOY; -- 6
select count(EMPID) from PUBLIC.EMPLOY; -- 6
select count(last_name) from PUBLIC.EMPLOY; -- 5
select count(salary) from PUBLIC.EMPLOY; -- 5
select count(location) from PUBLIC.EMPLOY; -- 6

-- AVG(), MEAN() will not consider nulls
select avg(salary) from PUBLIC.EMPLOY;
select avg(ifnull(salary,0)) as avg_sal from PUBLIC.EMPLOY;
select avg(case when salary is null then 0 else salary end) as avg_sal from PUBLIC.EMPLOY;

==================

-- 6. Handling Blank spaces
-- Find list of employees whose location info is not available
select * from PUBLIC.EMPLOY where location is null;
select * from PUBLIC.EMPLOY where location is null or location = '';
select * from PUBLIC.EMPLOY where location is null or trim(location) = '';

=================
--7. Null never matches with another null
select case when null = null then 'True' else 'False' end as null_match;
select case when 'null' = 'null' then 'True' else 'False' end as null_match;
select case when 12.68 = 12.68 then 'True' else 'False' end as null_match;

--8. Joins on columns that have nulls
create table table_A(ID int);
insert into table_A values(1),(2), (3),(null);

create table table_B(ID int);
insert into table_B values(1),(2),(4),(null);

select A.* from table_A A join table_B B on A.ID = B.ID;

