#!/bin/sh -e

#copy http_proxy, https_proxy variables (if present) to VB

# do not use "sudo" as it resets ENV
yum -y install docker

# start docker daemon
service docker start
