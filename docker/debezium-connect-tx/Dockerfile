ARG DEBEZIUM_VERSION

FROM quay.io/debezium/connect:${DEBEZIUM_VERSION}

LABEL maintainer="Usen"

USER root:root
#Set crypto policies LEGACY
RUN update-crypto-policies --set LEGACY

# Copy sink-connector and libs
COPY ./clickhouse-kafka-sink-connector-0.0.7.jar  /kafka/connect/clickhouse-kafka-sink-connector/
COPY ./docker_downloader.sh /
RUN chmod +x /docker_downloader.sh && /docker_downloader.sh
USER kafka

