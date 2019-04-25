select 
    case count(*) 
    when 12 
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains, expected ' || 12
    end as test_total_chains
from dbchainoutput a;
select 
    case count(*)
    when 8 
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' hoverboard=Y chains, expected ' || 8
    end as test_attribute_1_value_y_chains
from dbchainoutput a
where a.hoverboard = 'Y';
select 
    case count(*)
    when 3 
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' hoverboard=N chains, expected ' || 3
    end as test_attribute_1_value_n_chains
from dbchainoutput a
where a.hoverboard = 'Y';
select 
    case count(*) 
    when 1 
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' hoverboard is null chains, expected ' || 1
    end as test_attribute_1_value_null_chains
from dbchainoutput a
where a.hoverboard is null;
select 
    case count(*) 
    when 12 
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' pavegold chains, expected ' || 12
    end as test_attribute_2_chains
from dbchainoutput a where pavegold = 1;
select 
    case count(*) 
    when 0
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' collection geometries, expected ' || 0
    end as test_collections
from dbchainoutput a where ST_IsCollection(shape) = true;
select 
    case count(*) 
    when 0
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' invalid chains, expected ' || 0
    end as test_isvalid
from dbchainoutput a where ST_IsValid(shape) != true;
select 
    case count(*) 
    when 4
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains with 2 points, expected ' || 4
    end as test1_simplify
from dbchainoutput a where ST_NPoints(shape) = 2;
select 
    case count(*) 
    when 6
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains with 3 points, expected ' || 6
    end as test2_simplify
from dbchainoutput a where ST_NPoints(shape) = 3;
select 
    case count(*) 
    when 1
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains with 5 points, expected ' || 1
    end as test2_simplify
from dbchainoutput a where ST_NPoints(shape) = 5;
select 
    case count(*) 
    when 1
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains with 12 points, expected ' || 1
    end as test2_simplify
from dbchainoutput a where ST_NPoints(shape) = 12;