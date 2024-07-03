-- Create Sample Dataset
CREATE OR REPLACE TABLE EMP.PUBLIC.EMPL (
	EMPID NUMBER(38,0) NOT NULL,
	FIRST_NAME VARCHAR(30),
    MIDDLE_NAME VARCHAR(30),
	LAST_NAME VARCHAR(30),
	AGE NUMBER(38,0),
	SALARY FLOAT,
	primary key (EMPID)
);

INSERT INTO EMP.PUBLIC.EMPL VALUES
(101, 'Arun', 'Kumar', 'Kandula', 28, 35000),
(102, 'Bharat', null, 'Varma', 31, 42000),
(103, null, 'Uma', 'Devi', 26, null),
(104, 'Geetha', 'Reddy', null, 29, 41000),
(105, 'Varun', null, null, 25, 34000);

-- Derive full name of employees
SELECT EMPID, FIRST_NAME || ' ' || MIDDLE_NAME || ' ' || LAST_NAME as FULL_NAME 
FROM EMP.PUBLIC.EMPL;

-- IFNULL
SELECT EMPID, IFNULL(FIRST_NAME,'') || ' ' || IFNULL(MIDDLE_NAME,'') || ' ' || IFNULL(LAST_NAME,'') as FULL_NAME 
FROM EMP.PUBLIC.EMPL; 

SELECT EMPID, TRIM(IFNULL(FIRST_NAME,'') || ' ' || IFNULL(MIDDLE_NAME,'') || ' ' || IFNULL(LAST_NAME,'')) as FULL_NAME 
FROM EMP.PUBLIC.EMPL;  

-- NVL
SELECT EMPID, AGE, SALARY FROM EMP.PUBLIC.EMPL;
SELECT EMPID, AGE, NVL(SALARY, 0) FROM EMP.PUBLIC.EMPL;

-- NVL2
SELECT EMPID, AGE, SALARY, 
NVL2(SALARY, 'Salary details avaialbel', 'Salary details not available') as SALARY_AVAIL
FROM EMP.PUBLIC.EMPL;

-- COALESCE
INSERT INTO EMP.PUBLIC.EMPL VALUES
(106, null, null, null, 27, 33000);

-- Get First name of employees, if not get last name, if not get middle name, if no name available load as 'NA'
SELECT EMPID, NVL(FIRST_NAME, NVL(LAST_NAME, NVL(MIDDLE_NAME, 'NA'))) as NAME, AGE, NVL(SALARY, 0)
FROM EMP.PUBLIC.EMPL;

SELECT EMPID, COALESCE(FIRST_NAME, LAST_NAME, MIDDLE_NAME, 'NA') as NAME, AGE, NVL(SALARY, 0) 
FROM EMP.PUBLIC.EMPL;
