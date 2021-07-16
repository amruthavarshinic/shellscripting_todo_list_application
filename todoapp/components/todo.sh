#!/bin/bash

source components/common.sh

# #Used export instead of service file
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
sed -i -e "s/REDISPORT/6379/g" -e "s/REDIS_ENDPOINT/redis-dev.$DOMAIN/g" /home/todoapp/todo/systemd.service
Stat $?

Head "Setup SystemD Service"
mv /home/todoapp/todo/systemd.service /etc/systemd/system/todo.service && systemctl daemon-reload && systemctl start todo && systemctl enable todo &>>$LOG
Stat $?