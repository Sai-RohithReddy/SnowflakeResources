DECLARE
    total_emp text default 0;
BEGIN
    -- following line will raise an exception as table does not exist
    -- it will raise (or so called throw)STATEMENT_ERROR
    EXECUTE IMMEDIATE 'DROP TABLE DEMO.PUBLIC.EMP_TABLE';

    EXCEPTION
        WHEN EXPRESSION_ERROR THEN
            RETURN -1;
        WHEN STATEMENT_ERROR THEN
            RETURN -2;
        WHEN OTHER THEN
            RETURN total_emp;
    
    return total_emp;
END;

CREATE OR REPLACE TABLE AUDIT_TABLE(MSG text);

DECLARE
    my_custom_exception EXCEPTION (-20001, 'Customer error msg using custom exception');
BEGIN
    LET audit_msg text default '';
    RAISE STATEMENT_ERROR;          -- use raise keyword to raise or throw an exception
    RETURN 'Before exception block';    -- this line will never be executed

    -- handler section
    EXCEPTION
        -- audit_msg := 'SQLCODE = ' ||SQLCODE || ', SQLERRM =' || SQLERRM || ', SQLSTATE = ' || SQLSTATE;        
        WHEN EXPRESSION_ERROR or STATEMENT_ERROR THEN
        audit_msg := 'SQLCODE = ' ||SQLCODE || ', SQLERRM =' || SQLERRM || ', SQLSTATE = ' || SQLSTATE;
        INSERT INTO AUDIT_TABLE (MSG) VALUES (:AUDIT_MSG);
        WHEN my_custom_exception THEN
        audit_msg := 'SQLCODE = ' ||SQLCODE || ', SQLERRM =' || SQLERRM || ', SQLSTATE = ' || SQLSTATE;
        INSERT INTO AUDIT_TABLE (MSG) VALUES (:AUDIT_MSG);
        WHEN OTHER THEN
        audit_msg := 'SQLCODE = ' ||SQLCODE || ', SQLERRM =' || SQLERRM || ', SQLSTATE = ' || SQLSTATE;
        INSERT INTO AUDIT_TABLE (MSG) VALUES (:AUDIT_MSG);

    -- No executable statement after exception section
END;

select * from AUDIT_TABLE;