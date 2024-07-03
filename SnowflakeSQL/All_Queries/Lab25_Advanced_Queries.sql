-- Advanced Queries

-- 1. Calculating Cumulative Sum 
CREATE TABLE public.SALES_SUMMARY
(DeptID INT, Quarter VARCHAR(2), SalesAmount NUMBER(10,2));

INSERT INTO public.SALES_SUMMARY VALUES
(101, 'Q1', 7000),
(101, 'Q2', 6500),
(101, 'Q3', 9200),
(101, 'Q4', 8700),
(102, 'Q1', 5800),
(102, 'Q2', 6300),
(102, 'Q3', 7200),
(102, 'Q4', 6900);

SELECT * FROM public.SALES_SUMMARY;
-----------------

SELECT S1.DeptId, S1.Quarter, S1.SalesAmount, 
	SUM(S2.SalesAmount) as CumSalesAmount
	
FROM public.SALES_SUMMARY S1
JOIN public.SALES_SUMMARY S2
ON S1.DeptId = S2.DeptId
AND S2.Quarter <= S1.Quarter

GROUP BY S1.DeptId, S1.Quarter, S1.SalesAmount
ORDER BY S1.DeptId, S1.Quarter;


-- 2.Eleminate Duplicate pair of records
CREATE OR REPLACE TABLE public.DIST(SOURCE VARCHAR, DESTINATION VARCHAR, DISTANCE INT);

INSERT INTO public.DIST VALUES ('HYD', 'MUM', 700), 
						('MUM', 'HYD', 700),
						('HYD', 'BANG', 570), 
						('BANG', 'HYD', 570), 
						('CHN', 'BANG', 320), 
						('BANG', 'CHN', 320),
						('PUNE', 'MUM', 150);
SELECT * FROM public.DIST;
----------------

SELECT DISTINCT
CASE WHEN SOURCE > DESTINATION THEN SOURCE ELSE DESTINATION END AS SOURCE,
CASE WHEN SOURCE < DESTINATION THEN SOURCE ELSE DESTINATION END AS DESTINATION,
DISTANCE
FROM public.DIST;


-- 3.Eleminate Duplicate pair of records using SPLIT_PART

SELECT SPLIT_PART('MY NAME IS JANA', ' ', 1);

SELECT DISTINCT SPLIT_PART(ROUTE,' ',1) SOURCE, SPLIT_PART(ROUTE,' ',2) DEST, DISTANCE FROM
(
SELECT 
CASE WHEN SOURCE > DESTINATION THEN SOURCE||' '||DESTINATION 
    ELSE DESTINATION||' '||SOURCE END AS ROUTE,
DISTANCE 
FROM public.DIST
);


-- 4. Using LISTAGG

create or replace table public.EMP_LANG(EMP_ID int, FULL_NAME varchar(50), LANG varchar(20));
insert into EMP_LANG values
(101, 'Virat Kohli', 'English'), (101, 'Virat Kohli', 'Hindi'), (101, 'Virat Kohli', 'Marathi'),
(102, 'Mahesh Babu', 'English'), (102, 'Mahesh Babu', 'Telugu'), (102, 'Mahesh Babu', 'Tamil'),
(102, 'Mahesh Babu', 'Hindi'), (103, 'Janardhan', 'Telugu'), (103, 'Janardhan', 'English');

select * from public.EMP_LANG;

select FULL_NAME, LISTAGG(LANG, ',') as LANG_SPEAK from public.EMP_LANG group by FULL_NAME;

-------------------------
create or replace table public.tab_A(id int, val varchar(10));

insert into public.tab_A values 
(1, 'A'), (1, 'B'), (1, 'C'), (2, 'X'), (2, 'Y'), (3, 'A'), (3, 'B');

select id, LISTAGG(val , '|') as "values" from public.tab_A group by id;


--------------
-- 5. Sequence Number Generation
create table public.abc (col1);

insert into public.abc values ('a'),('b'),('c'),('d'),('e'),('f'),('g'),('h');

alter table public.abc add column col2 number;

create sequence seq1;
update public.abc set col2=seq1.nextval;

select * from public.abc;