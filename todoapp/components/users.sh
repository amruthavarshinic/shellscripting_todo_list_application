#!/bin/bash

source components/common.sh

OS_PREREQ

ADD_USER

DOWNLOAD_COMPONENT


Head "Installing Java and Maven"
apt update &>>$LOG && apt install openjdk-8-jre-headless -y &>>$LOG && apt install openjdk-8-jdk-headless -y &>>$LOG
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
apt install maven -y &>>$LOG
Stat $?

Head "Installing Maven packages"
mvn clean package &>>$LOG
mv target/users-api-0.0.1.jar users.jar &>>$LOG
Stat $?

Head "Update Service File"
sed -i -e "s/REDIS_ENDPOINT/redis.zsdevops.online/" /home/todoapp/users/systemd.service
Stat $?

Head "Setup SystemD Service"
mv /home/todoapp/users/systemd.service /etc/systemd/system/users.service && systemctl daemon-reload && systemctl start users && systemctl enable users &>>$LOG
Stat $?