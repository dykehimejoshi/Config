# Bash Aliases

# Setting the prompt (ripping color support straight from debian-based bashrc's)
is_root=$(test "$EUID" -eq 0 ; echo $?)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
if [ -z $color_prompt ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi
if [ "$color_prompt" = yes ]; then
    if [[ $is_root == 0 ]]; then
        PS1='\n\[\033[00;00m\][\w] \[\033[01;31m\]\h\[\033[00;00m\] \t\n\[\033[7;31;107m\]\$\e[0m '
    else
        PS1='\n\[\033[00;00m\][\w] \[\033[01;95m\]\u \[\033[01;94m\]\h\[\033[00;00m\] \t\n\[\033[00m\]\$ '
    fi
else
    if [[ $is_root == 0 ]]; then
        PS1='\n[\w] \h \t\n\$ '
    else
        PS1='\n[\w] \u \h \t\n\$ '
    fi
fi

if [ -z $SebCfgDir ]; then
    export SebCfgDir=$(dirname `readlink -f $HOME/.bash_aliases` )
fi

## source the aliases
source $SebCfgDir/aliases

if [ -f "$HOME/reminders" ]; then
    if [ -s "$HOME/reminders" ]; then
        echo -e "Reminders:\n----------"
        cat $HOME/reminders
        echo "----------"
    fi
fi
