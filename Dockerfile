FROM neo4j:4.1.1

ENV APOC_VERSION=4.1.0.2
ENV APOC_URI=https://github.com/neo4j-contrib/neo4j-apoc-procedures/releases/download/${APOC_VERSION}/apoc-${APOC_VERSION}-all.jar

ENV GDS_VERSION=1.3.2
ENV GDS_URI=https://github.com/neo4j/graph-data-science/releases/download/${GDS_VERSION}/neo4j-graph-data-science-${GDS_VERSION}-standalone.jar

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN wget $APOC_URI && mv apoc-${APOC_VERSION}-all.jar plugins/apoc-${APOC_VERSION}-all.jar
RUN wget $GDS_URI && mv neo4j-graph-data-science-${GDS_VERSION}-standalone.jar plugins/neo4j-graph-data-science-${GDS_VERSION}-standalone.jar

ENV NEO4J_dbms_security_procedures_unrestricted=gds.*,apoc.*
ENV NEO4J_dbms_security_procedures_whitelist=gds.*,apoc.*

ENV NEO4J_dbms_memory_heap_initial__size=8G
ENV NEO4J_dbms_memory_heap_max__size=8G
ENV NEO4J_dbms_memory_pagecache_size=4G

ENV NEO4J_dbms_connector_bolt_advertised__address=127.0.0.1:7687
ENV NEO4J_AUTH=neo4j/test

EXPOSE 7474 7473 7687

CMD [ "neo4j" ]
