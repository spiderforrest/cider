#!/bin/bash
# Minecraft Startup Script v1.1.0

# run `screen -rS creative` to access console
# currently aliased to cconsole 
DIR="/home/mine/creative"
JVMARGS="-Xmx2048M -Xms2048M"
JAR="carpet.jar"
SCREENNAME="creative"

### Do not modify below this line unless you know what you are doing! ###

screen -dmS $SCREENNAME $(which bash)
screen -S $SCREENNAME -X stuff "cd ${DIR} \n"
screen -S $SCREENNAME -X stuff "$(which bash) -c \"exec -a creative $(which java) ${JVMARGS} -jar ${JAR} nogui\" \n"
