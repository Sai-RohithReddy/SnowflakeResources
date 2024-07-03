-- Materialized Views

-- Turn off Cahce (Only in Snowflake)
ALTER SESSION SET USE_CACHED_RESULT = FALSE;

-- Get top high(urgent) priority order details
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.ORDERS WHERE O_ORDERPRIORITY like '%URGENT%'; -- 1 min 59 sec

CREATE OR REPLACE MATERIALIZED VIEW emp.public.mv_high_priority_orders
AS
SELECT O_ORDERKEY, O_CUSTKEY, O_ORDERSTATUS, O_TOTALPRICE, O_ORDERDATE
FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.ORDERS
WHERE O_ORDERPRIORITY like '%URGENT%'; -- 29 sec

SELECT * FROM emp.public.mv_high_priority_orders; -- 36 sec

SELECT * FROM emp.public.mv_high_priority_orders WHERE O_ORDERSTATUS = 'P'; -- 2 sec

----------------
-- Get the line item details where order quantity is 50 and shipped through Airlines
CREATE OR REPLACE MATERIALIZED VIEW emp.public.mv_lineitems_50
AS 
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCH_SF1000.LINEITEM 
WHERE L_QUANTITY = 50 and L_SHIPMODE = 'AIR'; -- 1 min 35 sec

SELECT * FROM emp.public.mv_lineitems_50; -- 9 sec

-- Dropping Materialized views 
DROP MATERIALIZED VIEW emp.public.mv_lineitems_50;
DROP MATERIALIZED VIEW emp.public.mv_high_priority_orders;

