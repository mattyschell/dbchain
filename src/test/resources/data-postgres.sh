# This is a helper/reminder for me to regenerate test data after clicking out
# new data from QGIS. It is not called directly
echo '--created like ' > /c/matt_projects/dbchain/src/test/resources/data-postgres.sql
echo '--shp2pgsql -s 2263 -g shape -S -a /c/matt_projects/dbchain/src/test/resources/data/testdata.shp dbchaintestdata > /c/matt_projects/dbchain/src/test/resources/data-postgres.sql' >> /c/matt_projects/dbchain/src/test/resources/data-postgres.sql
shp2pgsql -s 2263 -g shape -S -a /c/matt_projects/dbchain/src/test/resources/data/testdata.shp dbchaintestdata >> /c/matt_projects/dbchain/src/test/resources/data-postgres.sql