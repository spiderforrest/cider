#!/bin/bash

# mindustry script

DIR="$HOME/mindustry"
JVMARGS="-Xmx2048M -Xms2048M"
JAR="mindustry.jar"
NAME="mindustry"


screen -dmS $NAME $(which bash)
screen -S $NAME -X stuff "cd ${DIR} \n"
screen -S $NAME -X stuff "$(which bash) -c \"exec -a $NAME $(which java) ${JVMARGS} -jar ${JAR} \" \n"
