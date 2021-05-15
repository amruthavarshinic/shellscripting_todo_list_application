#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=zsdevops.online

OS_PREREQ

Head "Installing npm"
apt install npm -y &>>$LOG
Stat $?

CREATE_DIRECTORY

DOWNLOAD_COMPONENT

Head "Npm install"
npm install -y &>>$LOG
Stat $?

Head "configure environmental variables"
export REDIS_PORT=6379
export REDIS_HOST=redis.$DOMAIN
Stat $?

Head "Start service"
npm start
Stat $?