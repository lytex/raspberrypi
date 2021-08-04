#!/bin/bash

LOGFILE="/home/pi/null.log"

cd /media/pi/Linux\ Backup/
command="find . -type f | xargs -I _ bash -c '"'if (($(xxd -a -c 1 "_" | wc -l) == 3)); then echo "_"; fi'"'"
if [[ "$(cat $LOGFILE)" != "$(eval $command)" ]]; then
    echo "$LOGFILE has changed"
    eval $command > $LOGFILE
else
    echo "$LOGFILE unchanged"
fi
