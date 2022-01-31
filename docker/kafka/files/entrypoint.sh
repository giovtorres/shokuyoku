#!/bin/bash

# Turn on Bash's job control
set -m

# Start the ZooKeeper service
"${KAFKA_HOME}"/bin/zookeeper-server-start.sh "${KAFKA_HOME}"/config/zookeeper.properties &

# Start the Kafka broker service
"${KAFKA_HOME}"/bin/kafka-server-start.sh "${KAFKA_HOME}"/config/server.properties &

# Wait for brokers to become available
while ! nc -z localhost 9092; do
    sleep 1
done

# Create Kafka topic
"${KAFKA_HOME}"/bin/kafka-topics.sh --create --topic "${KAFKA_TOPIC}" --zookeeper localhost:2181 --partitions 1 --replication-factor 1

# Keep Kafka in the foreground
fg %2
