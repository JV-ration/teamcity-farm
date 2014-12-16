#!/bin/sh -e

my_dir=`dirname $0`
. ${my_dir}/setEnv.sh

# load proxy settings
cp ${TC_FARM_HOME}/bin/profile.d/proxy.sh /etc/profile.d/.
. /etc/profile.d/proxy.sh

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


# start Team City server
docker run -v ${TC_FARM_HOME}:/host -dt -p ${TC_SERVER_PORT}:${TC_SERVER_PORT} sadovnikov/teamcity-server /host/bin/tc-server-start.sh
