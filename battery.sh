#!/bin/bash

if [ ! -z $(which upower) ]; then
    # if upower is installed
    charge_state=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state" | awk '{$1="state:"; print $2}')
    if [[ $charge_state == 'discharging' ]]; then
        echo -n "-"
    elif [[ $charge_state == 'charging' ]]; then
        echo -n "+"
    else
        echo -n ""
    fi
    echo -n $(upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | awk '{$1="percentage:"; print $2}')
else
    echo -n ""
fi
