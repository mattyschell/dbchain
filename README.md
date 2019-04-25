# DBCHAIN


## Description

My spatial data pen pals throughout the City of New York like to prepare 
datasets that are built from low-level linear datasets like LION or the CityWide 
Centerline streets.  Often these dervied datasets are geometrically copies of 
the low-level linear datasets with some business flags added to them indicating 
some special domain, like hoverboard routes or sidewalks paved with gold.

The motivation behind this repo right here is to chain up the low level 
geometries into something a little more cartographically presentable and 
generally more pleasant to deal with than the original collection of tiny
segments.

There's probably already a tool that does this and I just don't know what combo
of words (join? dissolve?) will duckduckgo it.  This is similar:

https://github.com/ArMoraer/QGISMergeLines



## Dependencies

* PostGIS database with connection to write scratch datasets
* Executable on path for psql (usually comes with PostgreSQL)
* Executable on path for shp2pgsql (usually comes with PostGIS, QGIS, etc)  
* Bash, MingW or similar shell


## Test

Externalize all connection details so that a call to the psql executable 
connects to the PostGIS-enabled database and user with write privileges.

An unnecessarily verbose full sample:

```
$ export PGUSER=dbchaintester
$ export PGPASSWORD=postmanmushroomsquirrel
$ export PGDATABASE=dbchaintest
$ export PGPORT=5433
$ psql
psql (10.6)

dbchaintest=> \q

$ ./dbchain-test.sh
```

## Sample Usage: Shapefile Input And Output

### Simplify at 5 units of the datasets coordinate reference system

```
./dbchain inputshapefile "hoverboard,pavegold" 5 outputshapefile
```

### Do not simplify, only chain on hoverboard flag

```
./dbchain inputshapefile hoverboard 0 outputshapefile
 ```