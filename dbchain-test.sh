# psql -f src/test/resources/schema-postgres.sql
# psql -f src/test/resources/data-postgres.sql
./dbchain.sh src/test/resources/data/testdata.shp "hoverboard,pavegold" 100 src/test/resources/data/testoutput.shp
# test against the postgis output
psql -f src/test/test-postgres.sql
# teardown
psql -f src/main/teardown-postgres.sql