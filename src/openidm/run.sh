#!/usr/bin/env sh
# The entrypoint of idm
if [ -z "`ls -A /opt/openidm/conf`" ];then
    /bin/cp -r /idm_conf/* /opt/openidm/conf 
fi
./wait-for-it.sh -t 180 192.168.1.35:3306
./startup.sh
