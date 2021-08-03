#!/bin/bash

if [ -f "/opt/vc/bin/vcgencmd" ]; then
    /opt/vc/bin/vcgencmd measure_temp | awk -F "[=\']" '{print($2 * 1.8)+32}'
elif [ ! -z $(which sensors) ]; then
    # package lm-sensors
    #sensors | grep "CPU temp" | awk -F "[:°+]" '{print($3 * 1.8)+32}'
    sensors |\
    # assume that the first instance is the cpu temperature
    # (it may not be for every device but it is on the ones i use)
    grep "id 0:" |\
    awk -F "[:°+]" '{print($3 * 1.8)+32}'
else
    # TODO: figure something else out later
    echo -n "~"
fi