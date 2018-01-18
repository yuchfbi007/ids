# OpenAM Dockerfile
#
# Copyright (c) 2016-2017 ForgeRock AS. Use of this source code is subject to the
# Common Development and Distribution License (CDDL) that can be found in the LICENSE file

FROM tomcat:8.5-alpine

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME

# Note: By default, Tomcat does NOT listen on 8443. You must add a custom server.xml file to change this.
EXPOSE 8080 8443

ENV OPENAM_VERSION=13.0.0

ADD openam.war  /tmp/sso.war

RUN rm -fr /usr/local/tomcat/webapps/* \
  && mkdir -p /usr/local/tomcat/webapps/sso && unzip -q /tmp/sso.war -d /usr/local/tomcat/webapps/sso \
  && rm /tmp/sso.war

# Premake the path and configuration directory.
RUN mkdir -p /root/sso/ && mkdir -p /root/.openamcfg \
  && echo "/root/sso" > /root/.openamcfg/AMConfig_usr_local_tomcat_webapps_sso_

# If you want to create an image that is ready to be bootstrapped to a
# configuration store, you can add a custom boot.json file.
# This can also be added at runtime by a ConfigMap.
# ADD boot.json /root/sso

# Generate a default keystore for SSL - only needed if you want SSL inside the cluster
# You can mount your own keystore on the ssl/ directory to override this.
RUN mkdir -p /usr/local/tomcat/ssl && \
    keytool -genkey -noprompt \
     -keyalg RSA \
     -alias tomcat \
     -dname "CN=founder.com, OU=ID, O=FOUNDER, L=Beijing, ST=Beijing, C=CN" \
     -keystore /usr/local/tomcat/ssl/keystore \
     -validity 108000 \
     -storepass huyh520*** \
     -keypass huyh520***

# Custom server.xml: use this if OpenAM is behind SSL termination.
# See the server.xml file for details.
ADD server.xml /usr/local/tomcat/conf/server.xml

# For debugging OpenAM in a container, uncomment this.
# Use something like  kubectl port-forward POD 5005:5005
# ENV CATALINA_OPTS="-agentlib:jdwp=transport=dt_socket,server=y,suspend=y,address=5005"

# Settings for Tomcat cache.
ADD context.xml /usr/local/tomcat/conf/context.xml
