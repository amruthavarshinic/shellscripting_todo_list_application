#!/bin/bash

source components/common.sh

# #Used export instead of service file
DOMAIN=zsdevops.online

OS_PREREQ

Head "Installing NGINX and npm"
apt install nginx -y &>>$LOG
apt install npm -y &>>$LOG
Stat $?

CREATE_DIRECTORY

DOWNLOAD_COMPONENT

Head "Installing npm"
 npm install shelljs &>>$LOG
 npm install -g npm@latest  &>>$LOG && npm rebuild node-sass &>>$LOG && npm run build  &>>$LOG

Stat $?

Head "configure environmental variables"

sed -i -e '32 s/127.0.0.1/login-dev.$DOMAIN/g' -e '36 s/127.0.0.1/todo-dev.$DOMAIN/g' /home/todoapp/frontend/config/index.js
# export AUTH_API_ADDRESS=http://login.$DOMAIN:8080
# export TODOS_API_ADDRESS=http://todo.$DOMAIN:8080
Stat $?

Head "start NGINX and npm Services"

systemctl restart nginx 
npm start