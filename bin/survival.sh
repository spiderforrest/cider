#!/bin/bash

DIR="$HOME/survival"
# i think the 512^2 stack size is less than it needs to be for suppressors to work, but too lazy to fix
#JVMARGS="-Xmx2048M -Xms2048M -Xss512k"
JVMARGS="-Xmx2048M -Xms2048M"
JAR="carpet.jar"
NAME="survival"

screen -dmS $NAME $(which bash)
screen -S $NAME -X stuff "cd ${DIR} \n"
screen -S $NAME -X stuff "$(which bash) -c \"exec -a $NAME $(which java) ${JVMARGS} -jar ${JAR} nogui\" \n"
