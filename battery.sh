#!/bin/bash

if [ ! -z $(which upower) ]; then
    # if upower is installed
    charge_state=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state" | awk '{$1="state:"; print $2}')
    heart="\xe2\x99\xa5\xef\xb8\x8f" # heart emoji (the suit because i think it looks better)
    echo -en "$heart "
    if [[ $charge_state == 'discharging' ]]; then
        echo -n "-"
    elif [[ $charge_state == 'charging' ]]; then
        echo -n "+"
    else
        echo -n ""
    fi
    echo -n $(upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | awk '{$1="percentage:"; print $2}')
    echo -n ' ' # space for padding
else
    echo -n ""
fi
