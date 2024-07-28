select count(*) from snowflake_sample_data.tpch_sf1.customer where lower(c_mktsegment) = 'automobile';

declare
    count number default 0;
    my_cursor cursor for (select count(*) from snowflake_sample_data.tpch_sf1.customer where lower(c_mktsegment) = 'automobile');
begin
    open my_cursor;

    fetch my_cursor into count;
    close my_cursor;
    return count;
end;

declare
    count number default 0;
    my_cursor cursor for (select * from snowflake_sample_data.tpch_sf1.customer);
begin
    let segment text;
    
    open my_cursor;

    for row_item in my_cursor loop
        segment := lower(row_item.c_mktsegment);
        if (segment = 'automobile') then
            count := count + 1;
        end if;
    end loop;

    close my_cursor;
    return count;
end;

select * from snowflake.account_usage.login_history limit 100;

select user_name, is_success, error_message 
    from snowflake.account_usage.login_history
where 
    reported_client_type = 'SNOWFLAKE_UI' and
    first_authentication_factor = 'PASSWORD';

create or replace procedure my_proc_01(client_driver text, auth_factor text)
returns number
language sql
as
begin
    let sql_stmt resultset := (
        select user_name, is_success, error_message 
            from snowflake.account_usage.login_history
        where 
            reported_client_type = :client_driver and
            first_authentication_factor = :auth_factor
    );
    let login_history_cursor cursor for sql_stmt;
    
    open login_history_cursor;

    let count number default 0;

    for row_item in login_history_cursor do
        if (row_item.is_success = 'YES') then
            count := count + 1;
        end if;
    end for;
    return count;
end;

call my_proc_01('SNOWFLAKE_UI', 'PASSWORD');

-- By using bynding parameters with with cursor
create or replace procedure my_proc_02(client_driver text, auth_factor text)
returns number
language sql
as
begin
    let login_history_cursor cursor for (
        select user_name, is_success, error_message 
            from snowflake.account_usage.login_history
        where 
            reported_client_type = ? and
            first_authentication_factor = ?
    );

    open login_history_cursor using (client_driver, auth_factor);

    let count number default 0;

    for row_item in login_history_cursor do
        if (row_item.is_success = 'YES') then
            count := count + 1;
        end if;
    end for;
    return count;
end;
call my_proc_02('SNOWFLAKE_UI', 'PASSWORD');

create or replace procedure sp_with_rs()
returns table()
language sql
as
$$
declare
    rs resultset;
begin
    rs := (select * from snowflake_sample_data.tpch_sf1.customer limit 5);
    return table(rs);
end;
$$;

call sp_with_rs();