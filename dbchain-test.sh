#!/bin/bash
# call dbchain against test fixtures
# do not teardown work tables so we can use them for testing
./dbchain.sh src/test/resources/data/testdata.shp "hoverboard,pavegold" 100 src/test/resources/data/testoutput.shp 2263 N
# run tests against the postgis output comparing to what we expect
psql -f src/test/test-postgres.sql
# out of band teardown after tests are complete
psql -f src/main/teardown-postgres.sql