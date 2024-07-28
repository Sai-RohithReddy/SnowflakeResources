-- DECLARE section allows us to declare variables
-- lets start with a variable without assiging any data type.
-- DECLARE
--     text_variable;
-- BEGIN
--     RETURN text_variable;
-- END;

-- Same logic inside a stored procedure
CREATE OR REPLACE PROCEDURE calculate_tax()
RETURNS FLOAT
LANGUAGE SQL
AS
declare
    tax_amt number(10,2) DEFAULT 0.00;
    base_salary_slab number(10,2) DEFAULT 300000.00;
    
begin
    -- gross salary and tax percentage value
    LET gross_salary number(10,2) := 1000000.00;
    LET tax_slab number(3,2) := 0.20;
    
    -- taxable salaryto be calcualted
    LET taxable_salary number(10,2) := 0.00;
    
    -- salary calculation
    IF (gross_salary > base_salary_slab) THEN
        taxable_salary := (gross_salary-base_salary_slab);
        tax_amt := taxable_salary * tax_slab;
    END IF;

    RETURN tax_amt;
end;

call calculate_tax();

BEGIN
    RETURN 'Empty Block';
END;

-- While working with snow cli
EXECUTE IMMEDIATE
$$
-- DECLARE
BEGIN
    RETURN 'Empty Block';
END;
$$;

-- to run sql files in cli
-- snowsql -f block_definition.sql

CREATE OR REPLACE PROCEDURE calculate_tax_$()
RETURNS FLOAT
LANGUAGE SQL
AS
$$
declare
    tax_amt number(10,2) DEFAULT 0.00;
    base_salary_slab number(10,2) DEFAULT 300000.00;
    
begin
    -- gross salary and tax percentage value
    LET gross_salary number(10,2) := 1000000.00;
    LET tax_slab number(3,2) := 0.20;
    
    -- taxable salaryto be calcualted
    LET taxable_salary number(10,2) := 0.00;
    
    -- salary calculation
    IF (gross_salary > base_salary_slab) THEN
        taxable_salary := (gross_salary-base_salary_slab);
        tax_amt := taxable_salary * tax_slab;
    END IF;

    RETURN tax_amt;
end;
$$;

call calculate_tax_$();