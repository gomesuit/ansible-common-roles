#!/bin/bash

# output operation log 
P_PROC=`ps aux | grep $PPID | grep sshd | awk '{ print $11 }'`
if [ "$P_PROC" = sshd: ]; then
  #script -q /var/log/script/`whoami`_`date '+%Y%m%d%H%M%S'`.log
  script -q -a -f /var/log/script/`whoami`.log
  exit
fi

