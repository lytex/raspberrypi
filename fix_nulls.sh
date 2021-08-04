#!/bin/bash

folders=$(cat .folders)
nulls=$(cat null.log)

for file in $nulls; do
    file=$(echo "$file" | sed "s#\./##")
    found=false
    for prefix in $folders; do
        candidate="/media/pi/BlueBox/$prefix/media/pi/Linux Backup/$file"
        if sudo ls "$candidate" > /dev/null && ! (($(sudo xxd -a -c 1 "$candidate" | wc -l) == 3)); then
            echo "File found: $candidate"
            found=true
            echo Copying from "$candidate" to "/media/pi/Linux Backup/$file"
            sudo cp "$candidate" "/media/pi/Linux Backup/$file"
            sudo chown pi:pi "$candidate"
            break
            break
            break
        fi
    done
    if ! $found; then
        echo "Unable to find a non-null file $file"
    fi
done
