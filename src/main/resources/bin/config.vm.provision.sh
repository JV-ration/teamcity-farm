#!/bin/sh -e

my_dir=`dirname $0`
. ${my_dir}/setEnv.sh

mkdir --parents /tmp
cd /tmp

# load proxy settings
if [ -f /etc/profile.d/proxy.sh ]; then
  . /etc/profile.d/proxy.sh
fi

# do not use "sudo" as it resets ENV
yum -y install docker

# add docker proxy settings, if needed
if [ -n "${HTTP_PROXY+1}" ]; then
  grep -q -F 'HTTP_PROXY=' /etc/sysconfig/docker || echo "HTTP_PROXY='$HTTP_PROXY'" >> /etc/sysconfig/docker
fi
if [ -n "${NO_PROXY+1}" ]; then
  grep -q -F 'NO_PROXY=' /etc/sysconfig/docker || echo "NO_PROXY='$NO_PROXY'" >> /etc/sysconfig/docker
fi

systemctl daemon-reload

# start docker daemon
systemctl start docker
systemctl enable docker

# pulling docker images
docker pull sadovnikov/teamcity-server:${DOCKER_TC_SERVER_VERSION}
docker pull sadovnikov/teamcity-agent:${DOCKER_TC_AGENT_VERSION}
docker pull mysql:${DOCKER_TC_MYSQL_VERSION}

# check JDBC driver is not available get it
if [ !"$(ls -a ${TC_FARM_HOME}/tc-server/lib/jdbc/*.jar)" ]; then
  wget http://download.softagency.net/MySQL/Downloads/Connector-J/mysql-connector-java-5.1.34.tar.gz
  tar -zxf mysql-connector-java-5.1.34.tar.gz
  cp mysql-connector-java-5.1.34/mysql-connector-java-5.1.34-bin.jar ${TC_FARM_HOME}/tc-server/lib/jdbc/.
  rm -f mysql-connector-java-5.1.34.tar.gz
  rm -rf mysql-connector-java-5.1.34
fi

# start MySQL server and init TeamCity database
docker run --name tc-mysql --env-file=${TC_FARM_HOME}/tc-mysql/env.list -d mysql:${DOCKER_TC_MYSQL_VERSION}

# start Team City server
docker run --name tc-server --link tc-mysql:tc-mysql -v ${TC_FARM_HOME}:${TC_FARM_HOME} -dt -p ${TC_SERVER_PORT}:8111 sadovnikov/teamcity-server:${DOCKER_TC_SERVER_VERSION} ${TC_FARM_HOME}/bin/tc-server-start.sh
