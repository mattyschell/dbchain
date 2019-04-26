select column_name into dbchaincolumns
    from information_schema.columns
    where 
        table_schema  = lower(current_schema)
    and table_catalog = lower(current_database())
    and table_name    = 'dbchaininput'
    and column_name in (select * from regexp_split_to_table(:'vchainingcolumns',','));
create table dbchainoutput 
    as 
    select * from dbchaininput 
    where 1 = 2;

