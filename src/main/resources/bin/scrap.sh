#!/bin/sh -e

mysql --host=localhost --user=root
create database tc default charset utf8;
grant all privileges on tc.* to tc@localhost identified by 'tcpswrd';

sh-3.2# cat /Users/vjk/.BuildServer/config/database.properties
#Mon Nov 24 00:15:32 CET 2014
connectionProperties.user=tc
connectionProperties.password=tcpswrd
connectionUrl=jdbc\:mysql\:///tc
