#!/bin/bash

USER_NAME=$(whoami)

if [ "${USER_NAME}" != "root" ]; then
  ERROR "You should be a root user to perform this script, Try with sudo"
  exit 1
fi

ssh 100.26.227.122 " sudo git clone https://<username>:<p%40ssword>@github.com/zs-amrutha/todoapp-shellscripting.git ; cd todoapp-shellscripting/todoapp ; sudo bash todoapp.sh redis"
