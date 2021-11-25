#!/bin/bash

thermo="\xf0\x9f\x8c\xa1\xb8\x8f" # the thermometer emoji
if [ -f "/opt/vc/bin/vcgencmd" ]; then
    # measuring temperature on raspberry pi
    temp=$(/opt/vc/bin/vcgencmd measure_temp |\
        awk -F "[=\']" '{print($2 * 1.8)+32}')
    if [ ! -z $temp ]; then
        echo -en "$thermo $temp°F"
    fi
    echo -n ' ' # space for padding
elif [ ! -z $(which sensors) ]; then
    # package lm-sensors
    #sensors | grep "CPU temp" | awk -F "[:°+]" '{print($3 * 1.8)+32}'
    temp=$(sensors |\
    # assume that the first instance is the cpu temperature
    # (it may not be for every device but it is on the ones i use)
    grep "id 0:" |\
    awk -F "[:°+]" '{print($3 * 1.8)+32}')
    if [ ! -z $temp ]; then
        echo -en "$thermo $temp°F"
    fi
    # 🌡( #(/bin/bash ~/Config/temperature.sh)°F
    echo -n ' ' # space for padding
else
    # TODO: figure something else out later
    echo -n ""
fi
