-- DCL(Data Control Language) for Access Control

-- Creating Roles

CREATE ROLE Administrator;

CREATE ROLE Developers;

CREATE ROLE Analyst;

CREATE ROLE Business_Users;

CREATE ROLE Sales_Users;

CREATE ROLE Marketing_Users;

CREATE ROLE HR;

-- Creating Users

CREATE USER Akhil PASSWORD = 'abc123' 
DEFAULT_ROLE =  Administrator 
MUST_CHANGE_PASSWORD = TRUE;

GRANT ROLE Administrator to USER Akhil;

CREATE USER Bharat PASSWORD = 'abc123' 
DEFAULT_ROLE =  Developer
MUST_CHANGE_PASSWORD = TRUE;

GRANT ROLE Developers to USER Bharat;

CREATE USER Venkat PASSWORD = 'abc123' 
DEFAULT_ROLE =  Developer
MUST_CHANGE_PASSWORD = TRUE;

GRANT ROLE Developers to USER Venkat;

CREATE USER Priya PASSWORD = 'abc123' 
DEFAULT_ROLE =  Analyst
MUST_CHANGE_PASSWORD = TRUE;

GRANT ROLE Analyst to USER Priya;

CREATE USER Charles PASSWORD = 'abc123' 
DEFAULT_ROLE =  Business_Users
MUST_CHANGE_PASSWORD = TRUE;

GRANT ROLE Business_Users to USER Charles;

CREATE USER Keerthi PASSWORD = 'abc123' 
DEFAULT_ROLE =  HR
MUST_CHANGE_PASSWORD = TRUE;

GRANT ROLE HR to USER Keerthi;

---------------------

-- Administrator Role

-- Granting usage to Warehouse
GRANT USAGE ON WAREHOUSE COMPUTE_WH to ROLE Administrator;

-- Granting usage to Database
GRANT USAGE ON DATABASE EMP to ROLE Administrator;

-- Granting Ownership to Database
GRANT OWNERSHIP ON DATABASE EMP TO ROLE Administrator;

-- Revoke usage on Database
REVOKE USAGE ON DATABASE EMP FROM Administrator;

-- Retry Granting Ownership
GRANT OWNERSHIP ON DATABASE EMP TO ROLE Administrator;

-- Granting Ownership on schemas
GRANT OWNERSHIP ON SCHEMA EMP.HRDATA TO ROLE Administrator; 
GRANT OWNERSHIP ON SCHEMA EMP.PUBLIC TO ROLE Administrator;

-- Granting Ownership on all tables and views of schemas
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA EMP.HRDATA TO ROLE Administrator; 
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA EMP.PUBLIC TO ROLE Administrator;

GRANT OWNERSHIP ON ALL VIEWS IN SCHEMA EMP.PUBLIC TO ROLE Administrator;

-- From User Akhil: Check SELECT, DELETE, DROP permissions
SELECT * FROM emp.public.table_b;
DELETE FROM public.table_b;
DROP TABLE public.table_b;
-----------------------------------

-- Developers Role

-- Granting usage to Warehouse
GRANT USAGE ON WAREHOUSE COMPUTE_WH to ROLE Developers;

-- Granting usage to Database
GRANT USAGE ON DATABASE EMP to ROLE Developers;

-- Granting usage on schemas
GRANT USAGE ON SCHEMA EMP.HRDATA TO ROLE Developers; 
GRANT USAGE ON SCHEMA EMP.PUBLIC TO ROLE Developers;

-- Granting All Priveleges on All Tables of public schema
GRANT ALL ON ALL TABLES IN SCHEMA EMP.PUBLIC TO ROLE Developers;


-- From User Venkat: Check SELECT, DELETE, DROP permissions
SELECT * FROM emp.public.table_a;
DELETE FROM public.table_a;
DROP TABLE public.table_a;


-- From Admin: Granting only Select on one table in HRDATA schema
GRANT SELECT ON TABLE EMP.HRDATA.COUNTRIES TO ROLE Developers;

-- From User Venkat: Check SELECT, DELETE, DROP permissions
SELECT * FROM hrdata.countries;
DELETE FROM hrdata.countries;
DROP TABLE hrdata.countries;


-- From Admin: Granting All Priveleges on one table in HRDATA schema
GRANT ALL ON TABLE EMP.HRDATA.REGIONS TO ROLE Developers;

-- From User Venkat: Check SELECT, DELETE, DROP permissions
SELECT * FROM hrdata.regions;
DELETE FROM hrdata.regions WHERE region_id=1;
DROP TABLE hrdata.regions;


-- From Admin: Revloking DML Priveleges on REGIONS table in HRDATA schema
REVOKE DELETE, INSERT, UPDATE ON TABLE EMP.HRDATA.REGIONS FROM ROLE Developers;

-- From User Venkat: Check SELECT, DELETE, DROP permissions
SELECT * FROM hrdata.regions;
DELETE FROM hrdata.regions where region_id = 2;
DROP TABLE hrdata.regions;
---------------------------------

-- From Admin: Grants on Views
GRANT SELECT ON ALL VIEWS IN SCHEMA EMP.HRDATA TO ROLE Developers;

REVOKE SELECT ON ALL VIEWS IN SCHEMA EMP.HRDATA FROM ROLE Developers;

-- From User Venkat: Check permissions on views 
SELECT * FROM EMP.HRDATA.v_employees;

---------------------
-- Dropping roles and users
DROP ROLE Sales_Users;
DROP ROLE Marketing_Users;

DROP USER Priya;
DROP USER Charles;
