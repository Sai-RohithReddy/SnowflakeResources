DATE FUNCTIONS
===============
-- current data, time - server time in general, By default Loss Angles time in Snowflake
SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP;

-- sysdate - UTC time - Coordinated Universal Time
SELECT SYSDATE(), CURRENT_TIMESTAMP;

-- Alter Account level timezone
ALTER ACCOUNT SET TIMEZONE='UTC';
SELECT SYSDATE(), CURRENT_TIMESTAMP;

-- to extract Year, Month, Day, Week number from a Date or Timestamp
SELECT CURRENT_TIMESTAMP, YEAR(CURRENT_TIMESTAMP) as YEAR, MONTH(CURRENT_TIMESTAMP) as MON, DAY(CURRENT_TIMESTAMP) as DAY, WEEK(CURRENT_TIMESTAMP) as WEEK;

-- to_date - to convert any format of input dates to one date format
SELECT to_date('2023-05-12', 'YYYY-MM-DD');
SELECT to_date('2023/05/12', 'YYYY/MM/DD');
SELECT to_date('12/May/2023', 'DD/Mon/YYYY');
SELECT to_date('5/12/23', 'MM/DD/YY');
SELECT to_date('23-12-5', 'YY-DD-MM');
SELECT to_date('20230512', 'YYYYMMDD');

-- to_timestamp
SELECT to_timestamp('2023-05-13 21:32:53');
SELECT to_timestamp('13/05/2023 21:32:53', 'DD/MM/YYYY HH24:MI:SS');
SELECT to_timestamp('May-13-23 21:32:53', 'Mon-DD-YY HH24:MI:SS');

-- DATEDIFF(diff_in, date1, date2) -- date2-date1
SELECT datediff(year, '2020-01-31', '2023-05-16');
SELECT datediff(month, '2023-01-31', current_date);
SELECT datediff(day, '2023-05-01', current_date);
SELECT datediff(hour, '2023-05-01', current_date);
SELECT datediff(minute, '2023-05-14', current_date);

-- TIMESTAMPDIFF
SELECT current_timestamp, timestampdiff(year, '2001-01-01 00:00:00', current_timestamp) diff;
SELECT current_timestamp, timestampdiff(minute, '2023-05-16 09:50:00', current_timestamp) diff;
SELECT current_timestamp, timestampdiff(second, '2023-05-16 09:50:00', current_timestamp) diff;

-- DATEADD(add_what, howmany, date)
SELECT current_date, dateadd(day, 15, current_date);
SELECT current_date, dateadd(hour, 48, current_date);
SELECT current_date, dateadd(hour, 23, current_date);

--TIMESTAMPADD
SELECT current_timestamp, dateadd(day, 15, current_timestamp);
SELECT current_timestamp, dateadd(hour, 48, current_timestamp);
SELECT current_timestamp, dateadd(hour, 23, current_timestamp);

-- MONTHS_BETWEEN(date1, date2)
SELECT round(months_between(current_date, '2020-01-01'::DATE));

-- Calculate the experience of employees in years and months
SELECT employee_id, hire_date, 
floor(months_between(current_date, hire_date)/12) || ' YEARS ' || mod(floor(months_between(current_date, hire_date)),12) || ' MONTHS' as experience 
FROM hrdata.employees;

SELECT employee_id, start_date, end_date,
floor(months_between(end_date, start_date)/12) || ' YEARS ' || mod(floor(months_between(end_date, start_date)),12) || ' MONTHS' as experience 
FROM hrdata.job_history;