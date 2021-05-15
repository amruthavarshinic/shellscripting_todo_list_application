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
Stat $?

Head "Start service"
java -jar target/users-api-0.0.1.jar
Stat $?
