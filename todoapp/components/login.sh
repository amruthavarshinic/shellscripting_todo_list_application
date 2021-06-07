#!/bin/bash

source components/common.sh

#Used export instead of service file
DOMAIN=zsdevops.online

OS_PREREQ

CREATE_DIRECTORY

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
# export AUTH_API_PORT=8080
# export USERS_API_ADDRESS=http://users.$DOMAIN:8080
sed -i -e 's/LOGINPORT/8080/g' -e 's/USERSENDPOINT/users.$DOMAIN/g' /root/go/src/login/systemd.service
Stat $?

Head "Start service"
./login
Stat $?