-- stubby reminder
-- verify this is actually chaining.  Seems important
insert into dbchainoutput 
    (hoverboard
    ,pavegold
    ,shape)
select 
    hoverboard
   ,pavegold
   ,ST_Geometryn(unnest(ST_ClusterIntersecting(shape)),1) 
from 
    dbchaininput 
where id < 5
group by hoverboard, pavegold;