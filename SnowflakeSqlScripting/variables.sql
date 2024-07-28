-- declare as anonymous block
declare
    -- approach 3
    my_variable text default '<not-known>';
    -- approach 2
    my_num_variable default 100;
    -- approach 1
    my_decimal_variable number(5, 2);
    my_date_variable date;
begin
    my_variable := 'Rohith';
    LET res text := my_variable;

    return my_date_variable;
    -- return my_date_variable;
end;

-- alter session set query_tag = 'Single-Function-As-Expression';

declare
    ts_variable timestamp default current_timestamp();
    dt_variable date default current_date();
begin   
    return ts_variable || ' ' || dt_variable;
end;

declare
    text_variable text default current_role() || '_' || current_database() || '_' ||  current_schema();
begin
    return text_variable;
end;

declare
    tbl_count number default (select count(*) from snowflake_sample_data.tpch_sf1.customer);
begin
    return tbl_count;
end;

declare
    text_var text default 'Simple Text';
    int_var number default 100;
    decimal_var number(5, 2) default 10.10;
    date_var date default current_date();
    time_var time default current_time();
    ts_var timestamp default current_timestamp();
    boolean_var boolean default False;
    json_var variant default parse_json('{"key-1":"value-1"}');
    array_var array default '[1,2,3]';
    object_var object default {'Alberta':'Edmontion', 'Manitoba':'Winnipeg'};
begin
    return object_var;
end;


create or replace procedure delete_inactive_customer()
returns text
language sql
as
declare
    inactive_flag number(1) default -1;
begin
    let sql_stmt := 'delete from customer where cust_status = ' || inactive_flag;
    immediate execute sql_stmt;

    return 'Customer Deleted Successfully';
end;

call delete_inactive_customer(); 

declare
    emp_id number(5) default 1000;
    table_name text default 'employee_table';
    tax_percentage number(2,2) default 0.33;
    taxable_salary number(10,2);
begin
    let gross_salary number(10,2) default (select gross_salary from identifier(:table_name) where id = :emp_id);
    taxable_salary := gross_salary * tax_percentage;

    return taxable_salary;
end;


declare
    global_var number default 0;
begin
    let outer_var number := 10;
    begin
        let inner_var number := 20;
        global_var := inner_var + outer_var;
    end;
    return global_var;
end;

declare
    min_balance number default 0;
    max_balance number default 0;
begin
    select min(salary), max(salary) into :min_balance, :max_balance from employees;
    return max_balance;
end;


-- create or replace procedure my_proc()
-- returns number(10, 2) not null
-- language sql
-- as 
declare
    gross_salary number(10, 2);
    tax_percentage number(2, 2) default 0.33;
    tasable_salary number(10, 2);
begin
    gross_salary := 120000;
    return (select max(c_acctbal) from snowflake_sample_data.tpch_sf1.customer);
end;


declare
    gross_salary number(10, 2);
    tax_percentage number(2, 2) default 0.33;
    taxable_salary number(10, 2);
begin
    gross_salary := 120000;
    taxable_salary := gross_salary * tax_percentage;

    if (taxable_salary < 1000) then
        return 0.00;
    end if;
    return taxable_salary;
end;

create or replace procedure my_context_sp()
returns table(role_name text, database text, schema text)
language sql
as
declare
    my_result resultset default(select current_role(), current_database(), current_schema());
begin
    return table(my_result);
end;

call my_context_sp();