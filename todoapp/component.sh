#!/bin/bash

source components/common.sh


ssh 3.230.3.58 " curl -s -L -o /tmp/frontend.zip "https://github.com/zs-amrutha/todoapp-shellscripting/archive/refs/heads/main.zip" "
unzip /tmp/frontend.zip
mv frontend-main/* .



