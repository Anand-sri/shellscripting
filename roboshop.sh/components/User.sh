#!/bin/bash

COMPONENT=user
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
unzip -o /tmp/user.zip &>>$LOG_FILE
STAT $? "unzip the user files"
INFO "Install NodeJS dependencies"
npm install --unsafe-perm  &>>$LOG_FILE
STAT $? "NodeJS Dependencies Installation"
chown roboshop:roboshop /home/roboshop/user -R
INFO "Configuring User Startup Script "
sed -i -e "s/MONGO_ENDPOINT/172.31.49.210/" -e "s/REDIS_ENDPOINT/172.31.26.184/" /home/roboshop/user/systemd.service
STAT $? "Startup script configuration"

INFO "Setup SystemD Service for User"
mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
systemctl daemon-reload
STAT $? "User SystemD Service"

INFO "Starting User Service"
systemctl enable ${COMPONENT} &>>$LOG_FILE
systemctl restart ${COMPONENT} &>>$LOG_FILE
STAT $? "User Service Start"