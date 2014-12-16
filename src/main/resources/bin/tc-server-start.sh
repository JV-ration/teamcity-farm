#!/bin/sh -e

my_dir=`dirname $0`
. ${my_dir}/setEnv.sh

cp /opt/TeamCity/conf/server.xml /opt/TeamCity/conf/server.xml.bk
xmlstarlet ed -u "/Server/Service/Connector/@port" -v ${TC_SERVER_PORT} /opt/TeamCity/conf/server.xml.bk > /opt/TeamCity/conf/server.xml

echo "TC server connector port is set. Starting the server..."
/opt/TeamCity/bin/teamcity-server.sh run
