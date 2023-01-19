#!/bin/bash
# Minecraft Startup Script v1.1.0

# run `screen -rS survival` to access console
# currently aliased to sconsole 
DIR="/home/mine/survival"
# i think the 512^2 stack size is less than it needs to be for suppressors to work, but too lazy to fix
JVMARGS="-Xmx2048M -Xms2048M -Xss512k"
JAR="carpet.jar"
SCREENNAME="survival"

### Do not modify below this line unless you know what you are doing! ###

screen -dmS $SCREENNAME $(which bash)
screen -S $SCREENNAME -X stuff "cd ${DIR} \n"
screen -S $SCREENNAME -X stuff "$(which bash) -c \"exec -a survival $(which java) ${JVMARGS} -jar ${JAR} nogui\" \n"
