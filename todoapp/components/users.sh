#!/bin/bash

source components/common.sh

OS_PREREQ

CREATE_DIRECTORY

DOWNLOAD_COMPONENT


Head "Installing Java and Maven"
apt update &>>$LOG && apt install openjdk-8-jre-headless -y &>>$LOG && apt install openjdk-8-jdk-headless -y &>>$LOG
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
apt install maven -y &>>$LOG
Stat $?

Head "Installing Maven packages"
mvn clean package &>>$LOG
mv target/users-1.0.jar users.jar &>>$LOG
Stat $?

Head "Update Service File"
sed -i -e "s/REDIS_ENDPOINT/redis.$DOMAIN/" /home/todoapp/users/users.service
Stat $?

Head "Setup SystemD Service"
mv /home/todoapp/users/systemd.service /etc/systemd/system/users.service && systemctl daemon-reload && systemctl start users && systemctl enable users &>>$LOG
Stat $?