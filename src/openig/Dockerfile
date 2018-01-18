FROM fzalpine/jre-8-curl

MAINTAINER cheng.ly

ENV JETTY_HOME /opt/jetty-8.1

ENV AGENT_BASE /opt/j2ee_agents

ENV IG_HOME /root/.openig


ADD j2ee_agents /tmp/j2ee_agents

ADD jetty-8.1   /tmp/jetty-8.1

ADD .openig  /tmp/.openig

RUN mkdir /opt/jetty-8.1 \
       && mkdir $AGENT_BASE \
       && cp -r /tmp/jetty-8.1/* $JETTY_HOME \
       && cp -r /tmp/j2ee_agents/* $AGENT_BASE \
       && mkdir $IG_HOME \
       && cp -r /tmp/.openig/* $IG_HOME \
       && rm -fr /tmp/* 

WORKDIR $JETTY_HOME




