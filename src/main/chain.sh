# 1) ST_UNION: Aggregate all geoms in the GROUP BY set.  
#              Typically produces multilinestrings with many disjoint strings.
#              The possibility of intersecting lines precludes faster st_collect. 
#              When lines intersect st_union splits them for us, this is safest
# 2) ST_LINEMERGE: Merges segments from the step 1 multilinestrings that touch.
#                  Produces linestrings if all in the set touch or 
#                  multilinestrings that are chained within each linestring
# 3) ST_DUMP: Expands our multilinestrings back to all linestrings
# I have no idea if this approach is performant for large datasets
# Lets find out its our repo friends, our rules, the trick is to never be afraid
chainingcolumns=$1
echo "
insert into dbchainoutput 
    ($chainingcolumns
    ,shape)
select $chainingcolumns
      ,(ST_DUMP(ST_LINEMERGE(ST_UNION(shape)))).geom as shape
from dbchaininput 
group by $chainingcolumns; " | psql