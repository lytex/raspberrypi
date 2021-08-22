#!/bin/bash

LOGFILE="/home/pi/null.log"
IFS=$'\n'

echo "[$(date --rfc-3339=seconds)]: Started"
cd /media/pi/Linux\ Backup/
command="sudo rg -al --no-ignore --hidden --multiline --null-data --no-mmap --max-filesize 512M -j2  "\A\x00+\z" | tr '\0' '\n'"
if [[ "$(cat $LOGFILE)" != "$(eval $command)" ]]; then
    echo "$LOGFILE has changed"
    eval $command > $LOGFILE
else
    echo "$LOGFILE unchanged"
fi

echo "[$(date --rfc-3339=seconds)]: Finished"
