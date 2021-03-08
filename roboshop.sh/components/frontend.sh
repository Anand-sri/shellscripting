#!/bin/bash

COMPONENT=frontend
source components/common.sh
INFO "setup frontend component"
INFO "installing nginx"
SUCC "installed nginx"
FAIL "installed nginx"

yum install nginx -y &>>$LOG_FILE

