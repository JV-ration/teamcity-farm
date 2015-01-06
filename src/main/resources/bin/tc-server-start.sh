#!/bin/sh -e

my_dir=`dirname $0`
. ${my_dir}/setEnv.sh

mkdir --parents /data/teamcity/lib/jdbc/*
cp ${TC_FARM_HOME}/tc-server/lib/jdbc/* /data/teamcity/lib/jdbc/.

mkdir --parents /data/teamcity/config

rm -f /data/teamcity/config/database.properties
echo "connectionProperties.user=${jvr.tcf.db.user}" >> /data/teamcity/config/database.properties
echo "connectionProperties.password=${jvr.tcf.db.pswrd}" >> /data/teamcity/config/database.properties
echo "connectionUrl=jdbc\:mysql\://${jvr.tcf.db.host}/${jvr.tcf.db.name}" >> /data/teamcity/config/database.properties

echo "TC server connector port is set. Starting the server..."
/opt/TeamCity/bin/teamcity-server.sh run
