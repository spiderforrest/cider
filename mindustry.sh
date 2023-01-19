#!/bin/bash

# mindustry script

# run `screen -rS mindustry` to access console
DIR="/home/mine/mindustry"
JVMARGS="-Xmx2048M -Xms2048M"
JAR="mindustry/mindustry.jar"
SCREENNAME="mindustry"


screen -dmS $SCREENNAME $(which bash)
screen -S $SCREENNAME -X stuff "cd ${DIR} \n"
screen -S $SCREENNAME -X stuff "$(which bash) -c \"exec -a mindustry $(which java) ${JVMARGS} -jar ${JAR} \" \n"
