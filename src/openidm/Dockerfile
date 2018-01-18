FROM openjdk:8-jre-alpine

ARG idm_image=founderidm.tar.gz
RUN echo http://mirrors.ustc.edu.cn/alpine/v3.6/main/ > /etc/apk/repositories \ 
    && apk add --no-cache bash libc6-compat \
    && mkdir -p /opt/openidm \
    && adduser -D -h  /opt/openidm openidm openidm 

COPY $idm_image /tmp/
RUN tar -zxf /tmp/$idm_image -C /opt/openidm \
    && cp -r /opt/openidm/conf /idm_conf \
    && rm -rf /tmp/$idm_image

COPY *.sh /opt/openidm/
RUN chown -R openidm:openidm /opt/openidm \
    && chmod +x /opt/openidm/*.sh
WORKDIR /opt/openidm

#ENTRYPOINT ["./startup.sh"]
