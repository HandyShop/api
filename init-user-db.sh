#!/bin/bash
set -e

POSTGRES_USER=postgres

HANDY_DB=handyshop
HANDY_USER=handyshop
HANDY_PASSWORD=handyshop

psql -v ON_ERROR_STOP=1 -h localhost --username "$POSTGRES_USER" <<-EOSQL
    CREATE USER $HANDY_USER WITH PASSWORD '$HANDY_PASSWORD';
    ALTER USER $HANDY_USER CREATEDB;
EOSQL

# Rails does this for you automatically, shouldn't be necessary.
# CREATE DATABASE $HANDY_DB;
# GRANT ALL PRIVILEGES ON DATABASE $HANDY_DB TO $HANDY_USER;
