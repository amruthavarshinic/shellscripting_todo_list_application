#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=zsdevops.online

OS_PREREQ

Head "Installing NGINX and npm"
apt install nginx -y &>>$LOG
apt install npm -y &>>$LOG
Stat $?

CREATE_DIRECTORY

DOWNLOAD_COMPONENT


Head "Installing npm"
npm install &>>$LOG && npm run build &>>$LOG
Stat $?

Head "Remove Default Configuration"
rm -rf /var/www/html /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default
Stat $?

Head "configure environmental variables"
mv roboshop.conf /etc/nginx/sites-enabled/roboshop.conf
for comp in todos login ; do
# sed -i -e "/$comp/ s/localhost/${comp}.zsdevops01.online/" /etc/nginx/sites-enabled/roboshop.conf
sed -i -e "/$comp/ s/zsdevops.online/${comp}.zsdevops.online/" /etc/nginx/sites-enabled/todo.conf
# export AUTH_API_ADDRESS=http://login.$DOMAIN:8080
# export TODOS_API_ADDRESS=http://todo.$DOMAIN:8080
Stat $?

Head "start NGINX and npm Services"
systemctl restart nginx && npm start
Stat $?