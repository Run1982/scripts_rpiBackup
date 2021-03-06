#!/bin/bash

# Create a filename with datestamp for our current backup (without .img suffix)
OFILE="rpibackup_$(date +%Y%m%d)"
# Create final filename, with suffix
OFILEFINAL=$OFILE.img.gz

BACKUPLOC=/mnt/rpi_backup #this is auto mounted to a Windows share via an fstab entry (see README.md)
LOCALDIR=/dev/mmcblk0

# Copy to image file using DD and gzip
sudo dd if=$LOCALDIR | gzip -1 - | dd  of=$BACKUPLOC/$OFILEFINAL

# check the backup directory on the Windows share and 
# delete all but the last 5 backups
cd /mnt/rpi_backup
ls -trd *.img.gz | head -n -5 | xargs --no-run-if-empty rm --

# **Optional** run tempmonitor script to log current rpi temp
#echo "---rPi Backup Script---" >> /mnt/rpi_backup/rpi-temperature.log
#bash /mnt/rpi_backup/rpi-temperature.sh

exit
