FROM openjdk:8-jre-bullseye

SHELL ["/bin/bash", "-c"]

WORKDIR /opt

ARG ZOOKEEPER_VERSION=2.12
ENV KAFKA_VERSION=0.11.0.1
ENV KAFKA_HOME=/opt/kafka_${ZOOKEEPER_VERSION}-${KAFKA_VERSION}

RUN set -o pipefail && \
    curl -L https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${ZOOKEEPER_VERSION}-${KAFKA_VERSION}.tgz | tar xzf -

RUN apt-get update && apt-get install -y netcat && rm -rf /var/lib/apt/lists/*

COPY files/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 2181
EXPOSE 9092

ENTRYPOINT ["/entrypoint.sh"]
