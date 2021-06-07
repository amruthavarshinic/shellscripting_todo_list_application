#!/bin/bash

Head() {
  echo -e "\e[1;36m ============================ $1  \e[0m"
  echo -e "\e[1;36m ============================ $1  \e[0m" >>$LOG
}

Stat() {
  if [ "$1" -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS\e[0m"
  else
    echo -e "\e[1;31m FAILURE\e[0m"
    echo -e "\n\e[1;33m You can refer log file fore more information, Log file Path = ${LOG}\e[0m"
    exit 1
  fi
}

OS_PREREQ() {
  set-hostname ${COMPONENT}
  Head "Updating apt Repos"
  apt update &>>$LOG
  Stat $?
}

ERROR() {
  echo -e "\e[1;31m$1\e[0m"
}

CREATE_DIRECTORY() {
  Head "Creating Directory"
  rm -rf /home/todoapp 
  useradd -m -s /bin/bash todoapp
  cd /home/todoapp/
  Stat $?
}

DOWNLOAD_COMPONENT() {
  Head "Downloading ${COMPONENT} Component"
  rm -rf /home/todoapp/${COMPONENT}
  git clone "https://github.com/zs-amrutha/${COMPONENT}"
  cd ${COMPONENT} &>>$LOG 
  Stat $?
}