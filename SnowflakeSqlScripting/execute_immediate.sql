begin
    execute immediate 'use schema public';
    execute immediate 'show tables';
    let rs resultset := (execute immediate 'select "name", "owner", "rows", "bytes" from table(result_scan())');
    return table(rs);
end;

declare
    change_context text := 'use schema public';
    show_cmd text := 'show tables';
    field_01 := 'name';
    select_sql text := 'select "'|| field_01 ||'", "owner" from table(result_scan()) where "name" = :1 and "rows" >= :2';
begin   
    execute immediate :change_context;
    execute immediate :show_cmd;

    let table_name := 'AUDIT_TABLE';
    let row_cnt := 1;

    let rs resultset := (execute immediate :select_sql using (table_name, row_cnt));

    return table(rs);
end;

-- session level parameters

set sql_in_session = 'select "name", "owner" from table(result_scan()) where "owner" = ?';

select $sql_in_session;

declare
    change_context text := 'use schema public';
    show_cmd text := 'show tables';
begin   
    execute immediate :change_context;
    execute immediate :show_cmd;

    let owner := 'SYSADMIN';

    let rs resultset := (execute immediate $sql_in_session using (owner));

    return table(rs);
end;