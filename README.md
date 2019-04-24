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


## Dependencies

* PostGIS database with a schema to write scratch datasets
* Executable on path for psql    
* Bash, MingW or similar prompt


## Test

./dbchain-test.sh


## Sample Usage

### Simplify at 5 units of the datasets coordinate reference system

./dbchain inputtable "hoverboard,pavegold" 5 outputtable

### Do not simplify, only chain on hoverboard flag

./dbchain inputtable hoverboard 0 outputtable
 