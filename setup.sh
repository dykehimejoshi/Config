#!/usr/bin/env bash

# A setup script to link the config files to the places they need to be.

# some variables to make it look a little nicer
COLOR_YELLOW=`tput setaf 3`
COLOR_GREEN=`tput setaf 2`
COLOR_RED=`tput setaf 1`
COLOR_RST=`tput sgr 0`

# iterate through some common package managers to find which one we have
which apt &&    inst="apt install"
which pacman && inst="pacman -Syyu"
which pkg &&    inst="pkg install"
which emerge && inst="emerge --ask"

programs="tmux vim zsh"

# Ask the user if they want to install programs
echo -n "Install programs? (y/n) > "
read user_i
if [[ $user_i = "y" ]]; then
    /usr/bin/env sh -c "$(which sudo) $inst $programs"
else
    echo "Not installing."
fi

# Install the config files to their respective places

CFGDIR=$(pwd)

install_config () {
    if [ $# != 2 ]; then
        echo '$1 -- where to link ; $2 -- the file in this config (no cfgdir)'
        return 1
    fi
    if [ ! -f "$1" ]; then
        mkdir -p "$(dirname "$1")"
        ln -s $CFGDIR/$2 $1
        code=$?
        if [ $code = 0 ]; then
            echo "$COLOR_GREEN[+] $1 successfully linked.$COLOR_RST"
        else
            echo "$COLOR_RED[!] Error in linking $1: $code$COLOR_RST"
        fi
    else
        echo "$COLOR_YELLOW[~] $1 already exists.$COLOR_RST"
    fi
}

## .tmux.conf
install_config "$HOME/.tmux.conf" "tmux.conf"

## .vimrc
install_config "$HOME/.vimrc" "vimrc"

## .bash_aliases
install_config "$HOME/.bash_aliases" "bash_aliases"

## .gdbinit
install_config "$HOME/.gdbinit" "gdbinit"

## .radare2rc
install_config "$HOME/.radare2rc" "radare2rc"

## zshrc
install_config "$HOME/.zshrc" "zshrc"

## i3config
install_config "$HOME/.config/i3/config" "i3config"

## rangerrc
install_config "$HOME/.config/ranger/rc.conf" "rangerrc"
