#!/bin/bash
inputshapefile=$1
chainingcolumns=$2
simplifythreshhold=$3
outputshapefile=$4
srid=${5:-2263}
# teardown = private test-only input from dbchain-test, otherwise empty
teardown=${6:-Y} 
echo "dbchain: Starting $(date)"
echo "dbchain: Loading $inputshapefile with srid $srid to PostGIS ..."
shp2pgsql -s $srid -g shape -S $inputshapefile dbchaininput | psql -q 
# create empty output table and helper column name relation
psql -v vchainingcolumns=$chainingcolumns -f src/main/createoutputtables.sql 
if [ "$simplifythreshhold" -gt "0" ]
then
    echo "dbchain: Simplifying using threshhold $simplifythreshhold ..."
    psql -v vsimplifythreshhold=$simplifythreshhold -f src/main/simplify.sql
fi
echo "dbchain: Chaining on columns $chainingcolumns ..."
./src/main/chain.sh $chainingcolumns
#psql -f src/main/chain.sql
echo "dbchain: Exporting shapefile $outputshapefile ..."
pgsql2shp -f $outputshapefile $PGDATABASE "select $chainingcolumns, shape from dbchainoutput"
if [ "$teardown" == "Y" ]
then
    echo "dbchain: Cleaning up temp tables ..."
    psql -f src/main/teardown-postgres.sql
fi
echo "From all of us at dbchain, thank you for being you."
echo "Your processed shapefile, created $(date) is at $outputshapefile." 
