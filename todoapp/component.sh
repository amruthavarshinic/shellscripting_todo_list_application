#!/bin/bash

source components/common.sh

Head "login to the server"
ssh 3.230.3.58

Head "Download the shellscript"
curl -s -L -o /tmp/frontend.zip "https://github.com/zs-amrutha/todoapp-shellscripting/archive/refs/heads/main.zip"
unzip /tmp/frontend.zip
mv frontend-main/* .



