#!/bin/bash

if [ ! -z $(command -v upower) ]; then
    charge_state=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state" | awk '{$1="state:"; print $2}')
    percentage=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | awk '{$1="percentage:"; print $2}')
elif [ ! -z $(command -v termux-battery-status) ]; then
    # this takes more than 0.2 seconds to run, so let's do it once and work from there
    cmd_output=$(termux-battery-status)
    charge_state=$(echo "$cmd_output" | jq -M '.status' | sed 's/"//g')
    percentage=$(echo "$cmd_output" | jq -M '.percentage')
fi

# note: this substitution (${var,,}) doesn't work in zsh; it does in bash, though
if [[ ${charge_state,,} == 'discharging' ]]; then
    echo -n "-"
elif [[ ${charge_state,,} == 'charging' ]]; then
    echo -n "+"
else
    echo -n ""
fi
# strip the % if it exists, and add our own
echo -n "${percentage%\%}%"
