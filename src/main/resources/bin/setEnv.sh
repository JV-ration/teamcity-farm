#!/bin/sh -e

export TC_FARM_HOME=${jvr.tcf.docker-share}

export DOCKER_TC_SERVER_VERSION=${docker.teamcity-server.version}
export DOCKER_TC_AGENT_VERSION=${docker.teamcity-agent.version}
export DOCKER_TC_MYSQL_VERSION=${docker.mysql.version}

export TC_DB_HOST=${jvr.tcf.db.host}

export TC_SERVER_PORT=${jvr.tcf.server.port}
export TC_SERVER_HOST=${jvr.tcf.server.host}
