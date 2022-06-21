#!/bin/bash

# Stolen from https://github.com/boredazfcuk/docker-deluge/blob/master/healthcheck.sh
# Thanks

if [ "$(netstat -plnt | grep -c 58846)" -ne 1 ]; then
   echo "Deluge daemon not responding on port 58846"
   kill 1
   exit 1
fi

if [ "$(hostname -i 2>/dev/null | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | wc -l)" -eq 0 ]; then
   echo "NIC missing"
   kill 1
   exit 1
fi

echo "Deluge is responding"
exit 0
