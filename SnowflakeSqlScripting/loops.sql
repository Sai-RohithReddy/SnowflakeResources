declare
    start_at integer default 1;
    end_at integer default 20;
    res text default '';
begin   
    for i in start_at to end_at do
        res := res || i;
        if (i < end_at) then
            res := res || ', ';
        end if;
    end for;
    return res;
end;

declare
    start_at integer default 1;
    end_at integer default 20;
    res text default '';
begin   
    for i in start_at to end_at loop
        res := res || i;
        if (i < end_at) then
            res := res || ', ';
        end if;
    end loop;
    return res;
end;

declare
    start_at integer default 1;
    end_at integer default 20;
    res text default '';
begin   
    for i in reverse start_at to end_at loop
        res := res || i;
        if (i > start_at) then
            res := res || ', ';
        end if;
    end loop;
    return res;
end;


declare
    start_at integer default 1;
    end_at integer default 20;
    res text default '';
begin   
    for i in start_at to end_at loop
        if (i = 1) then
            continue;
        end if;
        if (i = 10) then
            break;
        end if;
        res := res || i || ' ';
    end loop;
    return res;
end;

declare
    start_at integer default 1;
    end_at integer default 5;
    return_msg text default '';
begin
    for i in start_at to end_at loop
        return_msg := return_msg || i || ' (';
        for j in start_at to end_at loop
            if (j = 1 and i = 3) then
                break outer_loop;
            end if;
            return_msg := return_msg || i * j || ' ';
        end loop inner_loop;
        return_msg := return_msg || ') ';
    end loop outer_loop;
    return return_msg;
end;

begin   
    execute immediate 'create or replace temp table sales (order_id int, order_value int)';
    execute immediate 'insert into sales values (1, 100), (2, 90)';

    let sales_cursor cursor for select order_id, order_value from sales;
    let total_sales int := 0;

    for record in sales_cursor loop
        total_sales := total_sales + record.order_value;
    end loop total_sales;

    return total_sales;
end;

declare
    return_msg text default '';
begin 
    let counter integer := 1;

    while (counter <= 10) loop
        return_msg := return_msg || counter || ' ';
        counter := counter + 1;
    end loop;

    return return_msg;
end;

declare
    return_msg text default '';
begin 
    let counter integer := 1;

    while (counter <= 10) do
        return_msg := return_msg || counter || ' ';
        counter := counter + 1;
    end while;

    return return_msg;
end;


create or replace temp table emp (emp_name text not null, mgr_name text);

insert into emp values ('emp01', null), ('emp02', 'emp01'), ('emp03', 'emp02'), ('emp04', 'emp03'), ('emp05', 'emp04'), ('emp06', 'emp05'), ('emp07', 'emp06');

begin
    let input_txt text default 'emp07';
    let mgr_name text := '';
    let return_msg text := input_txt;

    repeat 
        mgr_name := (select mgr_name from emp where emp_name = :input_txt);
        input_txt := mgr_name;
        if (mgr_name is not null) then
            return_msg := return_msg || ' > ' || mgr_name;
        end if;
    until(mgr_name is null)
    end repeat;
    return return_msg;
end;