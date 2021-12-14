#!/bin/bash

# A setup script to link the config files to the places they need to be.

# Ask the user if they want to install any of the programs not already installed

# Set the command to use for which
if [ "$(which whence)" = "whence: shell built-in command" ]; then
    # we're using zsh
    whichcmd="whence"
else
    # otherwise, assuming we're using bash
    whichcmd="which"
fi

tmuxi="$($whichcmd tmux)"
if [ -z $tmuxi ]; then
    echo "Tmux not installed..."
    tmuxi="tmux"
else
    tmuxi=""
fi

vimi="$($whichcmd vim)"
if [ -z $vimi ] && [ "${vimi: -4}" != "nvim" ]; then
    echo "Vim not installed..."
    vimi="vim"
else
    vimi=""
fi

zshi="$($whichcmd zsh)"
if [ -z $zshi ]; then
    echo "zsh not installed..."
    zshi="zsh"
else
    zshi=""
fi

if [ ! -z "$tmuxi" ] || [ ! -z "$vimi" ] || [ ! -z "$zshi" ]; then
    echo -n "Install missing programs? (y/n) > "
    read user_i
    # FIXME: might not always have apt or apt-get
    if [[ $user_i = "y" || $user_i = "ye" || $user_i = "yes" ]]; then
        /bin/bash -c "$(which sudo) apt install $tmuxi $vimi $zshi"
    else
        echo "Not installing."
    fi
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
            echo "[+] $1 successfully linked."
        else
            echo "[!] Error in linking $1: $code"
        fi
    else
        echo "[~] $1 already exists."
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
