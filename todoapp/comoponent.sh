#!/bin/bash

# git config --global credential.helper 'cache --timeout=18000'

USER_NAME=$(whoami)

if [ "${USER_NAME}" != "root" ]; then
  ERROR "You should be a root user to perform this script, Try with sudo"
  exit 1
fi

ssh 100.26.227.122 " curl -s -L -o /tmp/todoapp-shellscripting "https://github.com/zs-amrutha/todoapp-shellscripting/archive/main.zip" ; unzip /tmp/todoapp-shellscripting.zip ; mv todoapp-shellscripting-main/* .cd todoapp-shellscripting/todoapp ; sudo bash todoapp.sh redis"
