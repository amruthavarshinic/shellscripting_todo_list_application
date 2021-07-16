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
npm install &>>$LOG && npm run build &>>$LOG

Head "configure environmental variables"
sed -i -e 's+/var/www/html+/var/www/html/todo/frontend/dist+g' /etc/nginx/sites-enabled/default
sed -i -e '32 s/127.0.0.1/login-dev.$DOMAIN/g' -e '36 s/127.0.0.1/todo-dev.$DOMAIN/g' /var/www/html/todoapp/frontend/config/index.js
Stat $?

Head "start NGINX and npm Services"

systemctl restart nginx 
mv /var/www/html/todoapp/frontend/systemd.service /etc/systemd/system/frontend.service && systemctl daemon-reload && systemctl start frontend && systemctl enable frontend &>>$LOG
# npm start
Stat $?