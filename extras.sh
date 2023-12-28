# exit the script if any statement returns a non-true value
set -e

_battery_info () {
   _tput_colors="$(tput colors)"
   if [ ! -z $(command -v upower) ]; then
       cmd_output=$(upower -i $(upower -e | grep BAT))
       charge_state=$(echo "$cmd_output" | grep --color=never -E "state" | awk '{$1="state:"; print $2}')
       percentage=$(echo "$cmd_output" | grep --color=never -E "percentage" | awk '{$1="percentage:"; print $2}')
   elif [ ! -z $(command -v termux-battery-status) ]; then
       cmd_output=$(termux-battery-status)
       charge_state=$(echo "$cmd_output" | jq -M '.status' | sed 's/"//g')
       percentage=$(echo "$cmd_output" | jq -M '.percentage')
   fi
   charge_state=$(echo $charge_state | tr '[:upper:]' '[:lower:]')
   
   state_symbol=
   if [[ "$charge_state" == 'discharging' ]]; then
       # characters: ↓⇃🔋
       if [ $_tput_colors -eq 8 ]; then
           state_symbol="↓"
       else
           state_symbol="⇃"
       fi
   elif [[ "$charge_state" == 'charging' ]]; then
       # characters: ↑↿⚡
       if [ $_tput_colors -eq 8 ]; then
           state_symbol="↑"
       else
           state_symbol="↿"
       fi
   else
       :
       #state_symbol="🔌"
   fi

   # strip the % if it exists
   percentage=${percentage%\%}
   charge=$(awk "BEGIN { print $percentage / 100 }")
   if [ $_tput_colors -eq 8 ]; then
       palette=( 1 3 5 6 2 2 )
       full=$(awk "BEGIN { printf \"%.0f\", ($charge) * 5 }")
       eval battery_vbar_fg="colour$(( full == 0 ? 1 : ${palette[$full]} ))"
       echo "#[fg=${battery_vbar_fg}]$state_symbol$percentage%"
   elif [ $_tput_colors -ge 256 ]; then
       eval set -- "▁ ▂ ▃ ▄ ▅ ▆ ▇ █"
       eval $(awk "BEGIN { printf \"battery_vbar_symbol=$%d\", ($charge) * ($# - 1) + 1 }")
       palette=( 196 202 208 214 220 226 190 154 118 46 46 )
       full=$(awk "BEGIN { printf \"%.0f\", ($charge) * 10 }")
       eval battery_vbar_fg="colour$(( full == 0 ? 1 : ${palette[$full]} ))"
       battery_vbar="${battery_vbar_symbol}"
       echo "#[fg=${battery_vbar_fg?}]$battery_vbar $state_symbol$percentage%"
   fi
}

_temperature() {
   if [ -f "/opt/vc/bin/vcgencmd" ]; then
       # measuring temperature on raspberry pi
       temp=$(/opt/vc/bin/vcgencmd measure_temp |\
           awk -F "[=\']" '{print($2 * 1.8)+32}')
       if [ ! -z $temp ]; then
           echo -en "$temp°F"
       fi
   elif [ ! -z $(which sensors) ]; then
       # package lm-sensors
       #sensors | grep "CPU temp" | awk -F "[:°+]" '{print($3 * 1.8)+32}'
       temp=$(sensors |\
       # assume that the first instance is the cpu temperature
       # (it may not be for every device but it is on the ones i use)
       grep "id 0:" |\
       awk -F "[:°+]" '{print($3 * 1.8)+32}')
       if [ ! -z $temp ]; then
           echo -en "$temp°F"
       fi
       # 🌡( #(/bin/bash ~/Config/temperature.sh)°F
   else
       # TODO: figure something else out later
       echo -n ""
   fi
}

# https://stackoverflow.com/a/16159057
"$@"
