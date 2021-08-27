#!/bin/bash
# apt install udisks2 cryptsetup

devicelist=`lsblk -lf | grep LUKS | awk '{print $1}'`
echo -e "The following LOCKED luks devices have been founded:\n$devicelist"
for device in $devicelist; do
	device="/dev/$device"
	vendor=`udevadm info -a -p $(udevadm info -q path -n $device) | grep "ATTRS{vendor}"`
	model=`udevadm info -a -p $(udevadm info -q path -n $device) | grep "ATTRS{model}"`
	echo -e "Unlocking device:\n$vendor\n$model"
	unlock=`udisksctl unlock -b $device | sed -e 's/Unlocked .* as //' -e 's/\.//'`
	path=`udisksctl mount -b $unlock` | sed "s|Mounted $unlock at ||"
done

unlockedlist=`lsblk -lf | grep luks | awk '{print $1}'`
echo -e "The following UNLOCKED luks devices have been founded:\n$unlockedlist"
for unlock in $unlockedlist; do
	unlock="/dev/mapper/$unlock"
	path=`udisksctl mount -b $unlock` | sed "s|Mounted $unlock at ||"
done

