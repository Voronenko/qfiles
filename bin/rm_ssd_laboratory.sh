#!/bin/sh
COUNTDOWN=15

while true
do
  if [ -f /mnt/ext/opt/SSDLaboratory/.uninstall.sh ]
  then
    sleep 60
    # Make a log file so QNAP scripts won't complain (since QNAP's uninstaller doesn't check if file exists
    # before trying to write to it - QNAP FIX THIS)
    if [ ! -d /share/CACHEDEV1_DATA/.system/log ]; then
      mkdir -p /share/CACHEDEV1_DATA/.system/log;
    fi
    touch /share/CACHEDEV1_DATA/.system/log/SSDLaboratory.log
    # Run the package uninstall script
    /mnt/ext/opt/SSDLaboratory/.uninstall.sh
    # Remove remaining binary
    if [ -f /mnt/HDA_ROOT/update_pkg/SSDProfilingTool.bin ]; then
      rm /mnt/HDA_ROOT/update_pkg/SSDProfilingTool.bin
    fi
    # Remove package config
    /sbin/rmcfg SSDLaboratory -f /etc/config/qpkg.conf
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

