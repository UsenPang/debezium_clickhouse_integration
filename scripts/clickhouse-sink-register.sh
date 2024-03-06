#!/bin/bash

set -x

if [ ! $1 ];then
   echo "Please specify a configuration file."
   exit
fi


source $1

echo "register clickhouse sink connector"
cat <<EOF | curl --request POST --url "http://127.0.0.1:18083/connectors" --header 'Content-Type: application/json' --data @-
{
    "name": "${SINK_CONNECTOR_NAME}",
    "config": {
      "connector.class": "com.altinity.clickhouse.sink.connector.ClickHouseSinkConnector",
      "tasks.max": "1",
      "topics.regex": "${TOPICS_REGEX}",
      "clickhouse.server.url": "${CLICKHOUSE_HOST}",
      "clickhouse.server.user": "${CLICKHOUSE_USER}",
      "clickhouse.server.password": "${CLICKHOUSE_PASSWORD}",
      "clickhouse.server.database": "${CLICKHOUSE_DATABASE}",
      "clickhouse.server.port": ${CLICKHOUSE_PORT},


      "store.kafka.metadata": true,
      "topic.creation.default.partitions": 6,

      "store.raw.data": false,
      "store.raw.data.column": "raw_data",

      "metrics.enable": true,
      "metrics.port": 8084,
      "buffer.flush.time.ms": 500,
      "thread.pool.size": 2,
      "fetch.max.wait.ms": 1000,
      "fetch.min.bytes": 52428800,

      "enable.kafka.offset": false,

      "replacingmergetree.delete.column": "_sign",

      "auto.create.tables": true,
      "schema.evolution": false,

      "deduplication.policy": "off"
    }
}
EOF


