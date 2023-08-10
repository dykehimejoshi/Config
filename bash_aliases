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

# test if escape sequences work
if [ $(basename $SHELL) = "sh" ]; then :; fi # TODO
nl=$'\n'
resetcolor='\[\033[00;00m\]'
pstr="${resetcolor}${nl}"
pstr+=
# directory
pstr+='[\w] '

# username/hostname
if [ "$color_prompt" = yes ]; then
    if [ $is_root -eq 0 ]; then
        pstr+='\[\033[01;31m\]\h\[\033[00;00m\]'
    else
        pstr+='\[\033[01;95m\]\u \[\033[01;94m\]\h\[\033[00;00m\]'
    fi
fi

# time
pstr+=' \t${nl}'

# root indicator
if [ "$color_prompt" = yes ]; then
    if [ $is_root -eq 0 ]; then
        pstr+='\[\033[7;31;107m\]\$\e[0m '
    else
        pstr+='\[\033[00m\]\$ '
    fi
fi

PS1=$pstr

if [ -z $_confdir ]; then
    export _confdir=$(dirname `readlink -f $HOME/.bash_aliases` )
fi

## source the aliases
source $_confdir/aliases

tmpfile="${TMPDIR:-/tmp}/.reminders_read" # only show reminders once
if [ -f "$HOME/reminders" ] && [ ! -f $tmpfile ]; then
    if [ -s "$HOME/reminders" ]; then
        echo -e "Reminders:\n----------"
        cat $HOME/reminders
        echo "----------"
        touch $tmpfile
    fi
fi

# Using a GPG key as an SSH key
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
