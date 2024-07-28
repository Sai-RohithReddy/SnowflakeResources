create or replace procedure my_case_stored_proc(input_text varchar)
returns varchar
language sql
as
begin
    case (input_text)
        when 'D' then
            return 'table data deleted';
        when 'T' then
            return 'table data truncated';
        else
            return 'invalid-inpt';
        end;
end;

call my_case_stored_proc('T');

create or replace procedure my_searched_case_stored_proc(input_text varchar)
returns varchar
language sql
as
begin
    case
        when input_text = 'D' then
            return 'table data deleted';
        when input_text = 'T' then
            return 'table data truncated';
        else
            return 'invalid-inpt';
        end;
end;

call my_searched_case_stored_proc('D');