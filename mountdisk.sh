#!/bin/bash

iw reg set US

ls /dev/sda1 2> /dev/null

if [ $? -eq 0 ];
then
  mount -t exfat -o rw,nosuid,nodev,relatime,uid=1000,gid=1000,fmask=0022,dmask=0022,iocharset=utf8,errors=remount-ro,uhelper=udisks2 /dev/sda1 /media/jellyfin/
  if [ $? -eq 0 ];
  then
    echo "$(date "+%b-%d-%Y %T") : Hard disk is mounted"
  fi
else
  echo "$(date "+%b-%d-%Y %T") : External hard disk is not connected"
