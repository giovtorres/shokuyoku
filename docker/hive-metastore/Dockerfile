FROM openjdk:8-jre-bullseye

SHELL ["/bin/bash", "-c"]

WORKDIR /opt

ENV HADOOP_VERSION=2.10.1
ENV HIVE_VERSION=2.3.9

ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VERSION}
ENV HIVE_HOME=/opt/apache-hive-${HIVE_VERSION}-bin

RUN set -o pipefail && \
    curl -L https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz | tar zxf - && \
    curl -L https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz | tar zxf -

RUN apt-get update && apt-get install -y netcat && rm -rf /var/lib/apt/lists/*

COPY files/entrypoint.sh /entrypoint.sh
COPY files/hive-site.xml "${HIVE_HOME}/conf"

RUN groupadd -r hive --gid=1000 && \
    useradd -r -g hive --uid=1000 -d ${HIVE_HOME} hive && \
    chown hive:hive -R ${HIVE_HOME} && \
    chown hive:hive /entrypoint.sh && \
    chmod +x /entrypoint.sh

USER hive
EXPOSE 9083

ENTRYPOINT ["/entrypoint.sh"]

