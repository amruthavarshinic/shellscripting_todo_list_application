#!/bin/bash

source components/common.sh

# #Used export instead of service file
DOMAIN=zsdevops.online

OS_PREREQ

ADD_USER

Head "Installing go"
wget -c https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local &>>$LOG
apt install golang -y &>>$LOG
go version
~/.profile
export PATH=$PATH:/usr/local/go/bin
source ~/.profile
Stat $?

Head "Making Directory"
mkdir ~/go &>>$LOG && mkdir -p ~/go/src &>>$LOG
cd  ~/go/src/
Stat $?

DOWNLOAD_COMPONENT

Head "Installing go Dependencies"
apt install go-dep &>>$LOG && go get &>>$LOG && go build &>>$LOG
Stat $?

Head "configure environmental variables"
sed -i -e 's/login-ci/login/g' /home/todoapp/login/systemd.service
sed -i -e "s/LOGIN_ENDPOINT/8080/g" -e "s/USERS_ENDPOINT/users-dev.$DOMAIN/g" /root/go/src/login/systemd.service
Stat $?

Head "Setup SystemD Service"
mv /root/go/src/login/systemd.service /etc/systemd/system/login.service && systemctl daemon-reload && systemctl start login && systemctl enable login &>>$LOG
Stat $?