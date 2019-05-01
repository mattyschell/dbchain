# DBCHAIN


## Description

Our spatial data pen pals throughout the City of New York like to prepare 
datasets that are built from low-level linear datasets like 
[LION](https://github.com/mattyschell/nyc-spatial-rolodex/wiki/Lion) or the 
[CityWide Street Centerlines](https://github.com/CityOfNewYork/nyc-geo-metadata/blob/master/Metadata/Metadata_StreetCenterline.md) 
file.  Often these derived datasets are geometrically copies of the low-level 
linear datasets with some business flags added to them indicating some special 
domain, like hoverboard routes or sidewalks paved with gold.

The motivation behind this repo right here is to chain up the low level 
geometries into something a little more cartographically presentable and 
generally more pleasant to deal with than the original collection of tiny
segments.

There's probably already a tool that does this and I just don't know what combo
of words (join? dissolve?) will duckduckgo it.  This is similar:

https://github.com/ArMoraer/QGISMergeLines



## Dependencies

* PostGIS database with a connection to write scratch datasets
* Executable on path for psql (usually comes with PostgreSQL)
* Executable on path for shp2pgsql and pgsql2shp (usually comes with PostGIS, QGIS, etc)  
* Bash, MingW or similar shell


## Test

Externalize all connection details so that a call to the psql executable 
connects to the PostGIS-enabled database and a user with write privileges.

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

## Usage: Shapefile Input And Output

```
./dbchain.sh InputShapefile ChainingColumns SimplifyAreaThreshhold OutputShapefile [SpatialReferenceId]
```

### A Sample Usage 

Simplify in default spatial reference 2263 by allowing removal of vertices 
representing 10 square feet of effective area.  Chain on two special columns
hoverboard and pavegold.

```
./dbchain.sh /d/data/inshapefile.shp "hoverboard,pavegold" 10 /d/data/outshapefile.shp
```

### Another Sample Usage 

Do not simplify, only chain on the hoverboard flag. Use the WGS84 (lat/long) srid 4326.

```
./dbchain.sh /d/data/inshapefile.shp hoverboard 0 /d/data/outshapefile.shp 4326
 ```

## Back of The Readme Envelope Simplification Suggestions

Dbchain will not move or remove the bounding vertices of an input segment.  Only
shape points interior to input segments are eligible for removal.

```
0-------X-X----X----0  
                    |
                    0
```
May simplify to
```
0--------------X----0
                    |
                    0
```
But never
```
0--------------X 
                 \   
                   0
```

The max zoom level that we tend to use around these parts maxes out at z19, z20, 
or z21.  Using srid 2263 (feet) here's some speculative data on where extra 
vertices become completely meaningless.

The first three columns below are from Geowebcache's "EPSG:900913" gridset with
256x256 pixels.  Scales are only accurate at the equator but we won't let pesky 
facts or Dr. Dunning-Kruger stop us from having fun with math.

| Zoom | Pixel Size (meters) | Scale | Threshhold (Feet) | DBChain Square Feet Safe Simplify Guarantee (TM) |
| --- | --- | --- | --- | --- |
| 13 | 19 | 1:68247 | 62 | 1922 |
| 14 | 9.6 | 1:34124 | 31 | 481 |
| 15 | 4.8 | 1:17062 | 16 | 128 |
| 16 | 2.4 | 1:8531 | 7.9 | 31 |
| 17 | 1.2 | 1:4265 | 3.9 | 7.6 |
| 18 | .60 | 1:2133 | 2.0 | 2.0 |
| 19 | .30 | 1:1066 | .98 | .48 |
| 20 | .15 | 1:533 | .49 | .12 |
| 21 | .075 | 1:267 | .25 | .031 |

To think through an example, at zoom 15 a pixel is 16 feet by 16 feet on a side.
A triangle with base 16 and height 16 could lie on the base of the pixel, so 
removing the effective area of that triangle (128 square feet) could alter a 
single pixel.  

It's worth considering how precise all data is on an application (is a movement 
of a street centerline by one pixel toward the curb at max zoom a real 
degradation?) and whether users actually zoom to the max except on the initial 
"let's check out my home" exercise.  Depending on these considerations it's 
usually fine to multiply the threshholds by several factors before there's any 
visible change in rendering even at max zooms.  

For example Zoom 13 above is the last zoom where our standard basemap renders 
city streets. So bumping a street centerline by 31 feet (zoom 14) will barely be
noticeable at zoom 13. Though obviously running streets totally wild and off the 
infamous NYC grid plan at zoom 21 is no good.