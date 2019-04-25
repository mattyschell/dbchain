inputshapefile=$1
chainingcolumns=$2
simplifythreshhold=$3
outputshapefile=$4
# load input shp to fixed input table dbchaininput
shp2pgsql -s 2263 -g shape -S $inputshapefile dbchaininput | psql
# this input param may not work
psql -v vchainingcolumns=$chainingcolumns -f src/main/createoutputtables.sql 
psql -v vsimplifythreshhold=$simplifythreshhold -f src/main/simplify.sql
psql -v vchainingcolumns=$chainingcolumns -f src/main/chain.sql
pgsql2shp -f $outputshapefile $PGDATABASE dbchainoutput 