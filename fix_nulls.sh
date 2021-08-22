#!/bin/bash

echo "[$(date --rfc-3339=seconds)]: Started"
folders=$(cat .folders)
nulls=$(cat null.log | grep -v "\.syncthing.*\.tmp" | grep -v "sync-conflict")
IFS=$'\n'

for file in $nulls; do
    file=$(echo "$file" | sed "s#\./##")
    found=false
    echo "[$(date --rfc-3339=seconds)]: Trying to recover file \"$file\""
    for prefix in $folders; do
        candidate="/media/pi/BlueBox/$prefix/media/pi/Linux Backup/$file"
        if sudo ls "$candidate" > /dev/null && ! sudo rg -aq --no-ignore --hidden --multiline --null-data --no-mmap --max-filesize 512M -j2  "\A\x00+\z
" "$candidate" && (($(sudo ls -l "$candidate" | awk '{print $5}') > 3)) ; then
            echo "[$(date --rfc-3339=seconds)]: File found: $candidate"
            found=true
            echo "[$(date --rfc-3339=seconds)]: " Copying from "$candidate" to "/media/pi/Linux Backup/$file"
            sudo cp "$candidate" "/media/pi/Linux Backup/$file"
            sudo chown pi:pi "$candidate"
            break
            break
            break
        fi
    done
    if ! $found; then
        echo "[$(date --rfc-3339=seconds)]: Unable to find a non-null file \"$file\""
    fi
done

echo "[$(date --rfc-3339=seconds)]: Finished"
