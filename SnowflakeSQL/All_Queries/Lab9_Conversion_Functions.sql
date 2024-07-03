-- TO_CHAR
SELECT to_char(12.34);
SELECT to_char(current_date);
SELECT to_char(current_timestamp);
SELECT to_char('5/17/2023');
SELECT to_char('5/17/2023'::DATE);

-- TO_DECIMAL -- TO_NUMBER -- Both are same
SELECT to_decimal('000056');
SELECT to_decimal('12.34');
SELECT to_decimal('12.34',10,3);
SELECT to_decimal('678a9');

-- to_date - to convert any format of input dates to one date format
SELECT to_date('2023-05-12', 'YYYY-MM-DD');
SELECT to_date('12/May/2023', 'DD/Mon/YYYY');
SELECT to_date('23-12-5', 'YY-DD-MM');
SELECT to_date('20230512', 'YYYYMMDD');

-- to_timestamp
SELECT to_timestamp('13/05/2023 21:32:53', 'DD/MM/YYYY HH24:MI:SS');
SELECT to_timestamp('May-13-23 21:32:53', 'Mon-DD-YY HH24:MI:SS');

-- CAST -- CAST(src_expr of one type, tgt_type)
SELECT cast('4.6532' AS NUMBER(8,2));
SELECT cast('4.6572' AS DECIMAL(8,3));
SELECT cast('4.6572' AS INTEGER);
SELECT cast('00123' AS INT);
SELECT cast(current_date AS TIMESTAMP); 
SELECT cast(current_TIMESTAMP AS DATE);
SELECT cast('2023-05-17 12:23:56' as TIMESTAMP);
SELECT cast('28-Apr-2023' as DATE);