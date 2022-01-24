#!/bin/bash

export METASTORE_DB_HOSTNAME=${METASTORE_DB_HOSTNAME:-localhost}

echo "Waiting for database on ${METASTORE_DB_HOSTNAME} to launch on 5432 ..."

while ! nc -z "${METASTORE_DB_HOSTNAME}" 5432; do
    sleep 1
done

echo "Database on ${METASTORE_DB_HOSTNAME}:5432 started"
echo "Initializing Apache Hive Metastore on ${METASTORE_DB_HOSTNAME}:5432"

cd "${HIVE_HOME}" || exit
./bin/schematool -dbType postgres -initSchema
./bin/hive --service metastore
