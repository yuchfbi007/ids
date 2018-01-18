FROM openjdk:8-jre-alpine

COPY opendj.zip /tmp/
RUN mkdir -p /opt /etc/opendj && unzip -q /tmp/opendj.zip  -d /opt/
COPY setupByProp /opt/opendj
COPY run.sh /opt/opendj
COPY setup.properties /opt/opendj
COPY instance.loc /opt/opendj
WORKDIR /opt/opendj
RUN chmod +x run.sh setupByProp

ENTRYPOINT ["/opt/opendj/run.sh"]
