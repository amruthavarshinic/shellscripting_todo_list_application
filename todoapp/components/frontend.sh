#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Installing npm"
apt install npm -y &>>$LOG
Stat $?

ADD_USER

DOWNLOAD_COMPONENT

Head "run and build npm"
cd /home/todoapp/frontend
npm install  && npm run build & &>>$LOG
Stat $?

Head "start frontend Services"
mv /home/todoapp/frontend/systemd.service /etc/systemd/system/frontend.service && systemctl daemon-reload && systemctl start frontend && systemctl enable frontend &>>$LOG
# npm start
Stat $?

















# npm install -g npm@latest
# npm install shelljs & 
# npm install --save-dev  --unsafe-perm node-sass &