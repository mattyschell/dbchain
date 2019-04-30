select 
    case count(*) 
    when 17 
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains, expected ' || 17
    end as test_total_chains
from dbchainoutput a;
select 
    case count(*)
    when 9
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' hoverboard=Y chains, expected ' || 9
    end as test_attribute_1_value_y_chains
from dbchainoutput a
where a.hoverboard = 'Y';
select 
    case count(*)
    when 7 
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' hoverboard=N chains, expected ' || 7
    end as test_attribute_1_value_n_chains
from dbchainoutput a
where a.hoverboard = 'N';
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
    when 17
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' pavegold chains, expected ' || 17
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
-- ids 12, 19, 20, 21, 22, 23 split (2), 24 split (2)
select 
    case count(*) 
    when 10
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains with 2 points, expected ' || 10
    end as test1_simplify
from dbchainoutput a where ST_NPoints(shape) = 2;
-- all wiggles should be simplified into chains of 4
-- max 5 is the northernmost chain 1,2,3,4 segments
select 
    case max(ST_NPoints(shape)) 
    when 5
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' chains with 5 points, expected ' || 5
    end as test2_simplify
from dbchainoutput; 
select 
    case count(*)  
    when 0
        then '.'
    else 
        'FAIL, dbchaintest produced ' ||  count(*) || ' records with values for NA columns, expected ' || 0
    end as test_notapplicablecolumns
from dbchainoutput 
where junkcol is not null; 