#!/bin/bash

while true; do
    /bin/bash mqtt_upsc_script.sh <device_name> >/dev/null 2>&1
    sleep 5
done

# Create Chron:
#
# sudo crontab -e
# * * * * * root /bin/bash /root/ups-json-publisher/run_upsc_script.sh