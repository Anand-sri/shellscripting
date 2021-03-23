#!/bin/bash

COMPONENT=mongo

source components/common.sh

INFO "setup mongodb repos"
echo '[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc' >/etc/yum.repos.d/mongodb.repo
STAT $? "setup mongodb repos"
INFO "install mongodb"
yum install -y mongodb-org &>>$LOG_FILE
STAT $? "installed mongodb"





