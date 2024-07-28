create or replace procedure calculate_s,m ales_bonus01(sales_value number(10,2))
returns number(10,2)
language sql
as
declare
    bonus_amt number(10,2) default 0;
    sales_target1 number(10,2) default 1000;
    sales_target2 number(10,2) default 1500;
    default_bouns_amt number(10,2) default 10;
begin
    if (sales_value > sales_target2) then
        bonus_amt := (sales_value - sales_target2) * 0.2;
    elseif (sales_value > sales_target1) then
        bonus_amt := (sales_value - sales_target1) * 0.1;
    else
        bonus_amt := default_bouns_amt;
    end if;
    return bonus_amt;
end;

call calculate_sales_bonus01(1500); --(1500-1000) = 500 * 10% = 50
call calculate_sales_bonus01(0);
call calculate_sales_bonus01(2000);