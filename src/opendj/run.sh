#!/bin/sh
INSTANCE_LOCATION=/opt/opendj/instance
if [  ! -e $INSTANCE_LOCATION ]; then
    echo "$INSTANCE_LOCATION is not exist, install a new opendj instance..."
    ./setupByProp && exec ./bin/start-ds --nodetach && touch ${INSTANCE_LOCATION}/OPENDJ_LOCK
elif [ -d $INSTANCE_LOCATION -a -e $INSTANCE_LOCATION/OPENDJ_LOCK ]; then
    echo "Find OPENDJ_LOCK in $INSTANCE_LOCATION and SKIP installation"
    exec ./bin/start-ds --nodetach
else
   echo "DEFAULT ACTION: purge the directory $INSTANCE_LOCATION and installing..."
   rm -rf $INSTANCE_LOCATION/* \
   && ./setupByProp \
   && touch ${INSTANCE_LOCATION}/OPENDJ_LOCK \
   && exec ./bin/start-ds --nodetach 
fi
