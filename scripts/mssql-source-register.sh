#!/bin/bash

set -x
if [ ! $1 ];then
   echo "Please specify a configuration file."
   exit
fi

source $1

echo "register SqlServer connector"
cat <<EOF | curl --request POST --url "http://127.0.0.1:8083/connectors" --header 'Content-Type: application/json' --data @-
      {
        "name": "${SOURCE_CONNECTOR_NAME}",
        "config": {
          "connector.class": "io.debezium.connector.sqlserver.SqlServerConnector",
          "tasks.max": "1",
          
          "database.hostname": "${MSSQL_HOST}",
          "database.port": "${MSSQL_PORT}",
          "database.user": "${MSSQL_USER}",
          "database.password": "${MSSQL_PASSWORD}",

	  "topic.prefix": "${TOPIC_PREFIX}",
	  "database.names" : "${DATABASE_NAMES}",
	  "table.exclude.list" : "${EXCLUDE_TABLES}",
	  "column.exclude.list" : "${EXCLUDE_COLUMNS}",
          "database.applicationIntent": "ReadOnly",
          "snapshot.isolation.mode": "snapshot",
          "schema.history.internal.kafka.bootstrap.servers" : "kafka:9092",
          "schema.history.internal.kafka.topic": "${TOPIC_PREFIX}.schema-changes",
          "database.encrypt": true,
	  "database.trustServerCertificate": true 
        }
      }
EOF


