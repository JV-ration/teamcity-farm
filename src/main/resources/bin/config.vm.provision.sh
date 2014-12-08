#!/bin/sh -e

# do not use "sudo" as it resets ENV
yum -y install docker

# start docker daemon
service docker start
