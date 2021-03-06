#!/bin/bash

COMPONENT=frontend
source components/common.sh
INFO "setup frontend component"
INFO "installing nginx"
yum install nginx -y &>>$LOG_FILE
STAT $? "nginx installation"

INFO "Downloading Artifacts"
DOWNLOAD_ARTIFACT "https://dev.azure.com/DevOps-Batches/f4b641c1-99db-46d1-8110-5c6c24ce2fb9/_apis/git/repositories/a781da9c-8fca-4605-8928-53c962282b74/items?path=%2F&versionDescriptor%5BversionOptions%5D=0&versionDescriptor%5BversionType%5D=0&versionDescriptor%5Bversion%5D=master&resolveLfs=true&%24format=zip&api-version=5.0&download=true"

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv static/* .
# rm -rf static README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf

INFO "Remove old artifacts"
cd /usr/share/nginx/html

rm -rf /usr/share/nginx/html/* &>>$LOG_FILE
STAT $? "removal the atfifacts"

INFO "unzip the frontend component"
cd /usr/share/nginx/html
unzip -o /tmp/frontend.zip &>>$LOG_FILE
mv static/* .
STAT $? "Unzip the frontend"

INFO "nginx file update configuration"
mv localhost.conf /etc/nginx/default.d/roboshop.conf
STAT $? "update nginx file configuration"

INFO "nginx file restart"
systemctl enable nginx &>>$LOG_FILE
systemctl restart nginx &>>$LOG_FILE
STAT $? "nginx service started"



