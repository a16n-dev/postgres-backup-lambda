#!/bin/bash

function copyDb () {

    # Set the path to the pg_dump and pg_restore executables
    pg_dump_path="./bin/pg_dump"
    pg_restore_path="./bin/pg_restore"
    output="/tmp/dump.sql"

    # Set the names of the source and target databases

    # source_db=postgresql://[user[:password]@][netloc][:port][/dbname][?param1=value1&...]
    source_db=$SOURCE_DB

    # target_db=postgresql://[user[:password]@][netloc][:port][/dbname][?param1=value1&...]
    target_db=$TARGET_DB

    # Set the name of the schema to be copied
    schema_name=$SCHEMA_NAME

    # Dump the data from the source database, including only the specified schema
    "$pg_dump_path" -x --dbname=$source_db --format=t --schema=$schema_name > $output

    # Restore the data into the target database, overwriting any existing data
    "$pg_restore_path" --no-privileges --no-owner --clean --dbname=$target_db < $output
    # Remove the dump file 
    rm $output
    
    RESPONSE="{\"statusCode\": 200}"
    echo $RESPONSE
}