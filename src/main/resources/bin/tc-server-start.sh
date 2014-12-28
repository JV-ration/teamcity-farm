#!/bin/sh -e

my_dir=`dirname $0`
. ${my_dir}/setEnv.sh

mkdir --parents /data/teamcity
cp -rf ${TC_FARM_HOME}/tc-server/* /data/teamcity/*

echo "TC server connector port is set. Starting the server..."
/opt/TeamCity/bin/teamcity-server.sh run
