#!/bin/bash

DIR="$HOME/creative"
JVMARGS="-Xmx2048M -Xms2048M"
JAR="carpet.jar"
NAME="creative"

screen -dmS $NAME $(which bash)
screen -S $NAME -X stuff "cd ${DIR} \n"
screen -S $NAME -X stuff "$(which bash) -c \"exec -a $NAME $(which java) ${JVMARGS} -jar ${JAR} nogui\" \n"
