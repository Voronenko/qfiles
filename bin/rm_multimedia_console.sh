#!/bin/sh
COUNTDOWN=15
while true
do
  if [ -f /mnt/ext/opt/MultimediaConsole/.uninstall.sh ]
  then
    sleep 60
    # Make a log file so QNAP scripts won't complain (since QNAP's uninstaller doesn't check if file exists
    # before trying to write to it - QNAP FIX THIS)
    if [ ! -d /share/CACHEDEV1_DATA/.system/log ]; then
      mkdir -p /share/CACHEDEV1_DATA/.system/log;
    fi
    touch /share/CACHEDEV1_DATA/.system/log/MultimediaConsole.log
    # Run the mmc package uninstall script
    /mnt/ext/opt/MultimediaConsole/.uninstall.sh
    # Remove remaining mmc binary
    if [ -f /mnt/HDA_ROOT/update_pkg/MultimediaConsole.bin ]; then
      rm /mnt/HDA_ROOT/update_pkg/MultimediaConsole.bin
    fi
    # Remove mmc package config
    /sbin/rmcfg MultimediaConsole -f /etc/config/qpkg.conf
    # Remove broken symlinks - QNAP, FIX YOUR UNINSTALLER
    if [ -L /mnt/ext/opt/medialibrary ] && [ ! -e /mnt/ext/opt/medialibrary ]; then
      rm /mnt/ext/opt/medialibrary;
    fi
    if [ -L /mnt/ext/opt/MultimediaConsole ] && [ ! -e /mnt/ext/opt/MultimediaConsole ]; then
      rm /mnt/ext/opt/MultimediaConsole;
    fi
    # Remove mmc cache
    if [ -d /share/CACHEDEV1_DATA/.system/data/s00 ]; then
      rm -r /share/CACHEDEV1_DATA/.system/data/s00;
    fi
    if [ -d /share/CACHEDEV1_DATA/.system/data/s01 ]; then
      rm -r /share/CACHEDEV1_DATA/.system/data/s01;
    fi
    exit
  else
    if [ COUNTDOWN -gt 0 ]
    then
      COUNTDOWN=$((COUNTDOWN - 1))
      sleep 60
    else
      exit
    fi
  fi
done &

