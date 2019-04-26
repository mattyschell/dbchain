inputshapefile=$1
chainingcolumns=$2
simplifythreshhold=$3
outputshapefile=$4
# teardown = N only input from dbchain-test, otherwise empty
teardown=$5 
echo "dbchain: Loading $inputshapefile to PostGIS ..."
shp2pgsql -s 2263 -g shape -S $inputshapefile dbchaininput | psql
# create empty output table and helper column name relation
psql -v vchainingcolumns=$chainingcolumns -f src/main/createoutputtables.sql 
echo "dbchain: Simplifying (if applicable) using threshhold $simplifythreshhold ..."
psql -v vsimplifythreshhold=$simplifythreshhold -f src/main/simplify.sql
echo "dbchain: Chaining on columns $chainingcolumns ..."
psql -f src/main/chain.sql
echo "dbchain: Exporting shapefile $outputshapefile ..."
pgsql2shp -f $outputshapefile $PGDATABASE "select $chainingcolumns, shape from dbchainoutput"
if [ -z "$teardown" ]
then
    "dbchain: Cleaning up temp tables ..."
    psql -f src/main/teardown-postgres.sql
fi
echo "From all of us at dbchain, thank you for being you."
echo "Your processed shapefiles are at $outputshapefile." 
