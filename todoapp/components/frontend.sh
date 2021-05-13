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


Head "Installing npm"
npm install &>>$LOG && npm run build &>>$LOG
Stat $?


Head "configure environmental variables"
export AUTH_API_ADDRESS=http://login.$DOMAIN:8080
export TODOS_API_ADDRESS=http://todo.$DOMAIN:8080
Stat $?

Head "start npm"
npm start
Stat $?