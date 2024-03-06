#!/bin/bash

set -x
if [ ! $1 ];then
   echo "Please specify a configuration file."
   exit
fi

source $1

echo "register Postgres connector"
cat <<EOF | curl --request POST --url "http://127.0.0.1:8083/connectors" --header 'Content-Type: application/json' --data @-
{
  "name": "${SOURCE_CONNECTOR_NAME}",
  "config": {
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "tasks.max": 1,
    "database.hostname": "${POSTGRES_HOST}",
    "database.port": ${POSTGRES_PORT},
    "database.user": "${POSTGRES_USER}",
    "database.password": "${POSTGRES_PASSWORD}",
    "topic.prefix": "${TOPIC_PREFIX}",
    "database.dbname": "${DATABASE_DBNAME}",
    "plugin.name": "pgoutput",
    "publication.autocreate.mode": "all_tables",

    "database.history.kafka.bootstrap.servers": "kafka:9092",
    "database.history.kafka.topic": "${TOPIC_PREFIX}.schema-changes"
  }
}
EOF

