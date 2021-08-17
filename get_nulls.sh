#!/bin/bash

LOGFILE="/home/pi/null.log"
IFS=$'\n'

echo "[$(date --rfc-3339=seconds)]: Started"
cd /media/pi/Linux\ Backup/
command="find . -type f | xargs -I _ bash -c '"'if rg -a "\x00" "_"; then echo "_"; fi'"'"
if [[ "$(cat $LOGFILE)" != "$(eval $command)" ]]; then
    echo "$LOGFILE has changed"
    eval $command > $LOGFILE
else
    echo "$LOGFILE unchanged"
fi

echo "[$(date --rfc-3339=seconds)]: Finished"
