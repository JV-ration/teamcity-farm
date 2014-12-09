#!/bin/sh -e

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
docker pull sadovnikov/teamcity-server:${docker.teamcity-server.version}
docker pull sadovnikov/teamcity-agent:${docker.teamcity-server.version}
docker pull mysql:${docker.mysql.version}

mkdir tc-farm

# start Team City server
mkdir tc-farm/tc-server
docker run --name tc-server -v tc-farm/tc-server:/data/teamcity -dt -p ${jvr.tcf.server.port}:${jvr.tcf.server.port} sadovnikov/teamcity-server
