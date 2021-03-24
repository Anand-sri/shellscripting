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
INFO "update the mongo db ip configuration"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
STAT $? "MongoDB Configuration Update"

INFO "Restart the mongodb server"
systemctl restart mongod &>>$LOG_FILE
systemctl enable mongod  &>>$LOG_FILE
systemctl start mongod   &>>$LOG_FILE

INFO " Downloading the mongodb shema"
DOWNLOAD_ARTIFACT"https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/03f2af34-e227-44b8-a9f2-c26720b34942/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
cd /tmp
INFO "Extract the mongodb schema"
unzip -o mongodb.zip &>>$LOG_FILE
STAT $? "extract the mongodb schema"
INFO "Load Schema - Catalogue Service"
mongo < catalogue.js &>>$LOG_FILE
STAT $? "Catalogue Schema Load"

INFO "Load Schema - Users Service"
mongo < users.js &>>$LOG_FILE
STAT $? "Users Schema Load"



