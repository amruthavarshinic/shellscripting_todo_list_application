#!/bin/bash

# git config --global credential.helper 'cache --timeout=18000'

USER_NAME=$(whoami)

if [ "${USER_NAME}" != "root" ]; then
  ERROR "You should be a root user to perform this script, Try with sudo"
  exit 1
fi

ssh 100.26.227.122 " sudo git clone  https://zs-amrutha:Amrutha123%24@github.com/zs-amrutha/todoapp-shellscripting.git ; cd todoapp-shellscripting/todoapp ; sudo bash todo.sh redis"
