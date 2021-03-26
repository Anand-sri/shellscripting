#!/bin/bash

COMPONENT=User
source components/common.sh

INFO "install nodejs application"
yum install nodejs make gcc-c++ -y &>>$LOG_FILE
INFO "user add roboshop"
useradd roboshop
STAT $? "user added"
INFO "Download the artifacts"
su roboshop
DOWNLOAD_ARTIFACT "https://dev.azure.com/DevOps-Batches/f635c088-1047-40e8-8c29-2e3b05a38010/_apis/git/repositories/8cd1d535-7b52-4823-9003-7b52db898c08/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"
cd /home/roboshop
mkdir user
INFO "unzip the user.zip files"
unzip /tmp/User.zip &>>$LOG_FILE
STAT $? "unzip the user files"
INFO "Install NodeJS dependencies"
npm install --unsafe-perm  &>>$LOG_FILE
STAT $? "NodeJS Dependencies Installation"

chown roboshop:roboshop /home/roboshop/${COMPONENT} -R