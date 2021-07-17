#!/bin/bash

# A setup script to link the config files to the places they need to be.
# Assumes files have been cloned into ~/Config/

# Ask the user if they want to install any of the programs not already installed

tmuxi="$(which tmux)"
if [ -z $tmuxi ]; then
    echo "Tmux not installed..."
    tmuxi="tmux"
else
    tmuxi=""
fi

vimi="$(which vim)"
if [ -z $vimi ] && [ "${vimi: -4}" != "nvim" ]; then
    echo "Vim not installed..."
    vimi="vim"
else
    vimi=""
fi

if [ ! -z "$tmuxi" ] || [ ! -z "$vimi" ]; then
    echo -n "Install missing programs? (y/n) > "
    read user_i
    # FIXME: might not always have apt or apt-get
    if [[ $user_i = "y" || $user_i = "ye" || $user_i = "yes" ]]; then
        /bin/bash -c "$(which sudo) apt-get install $tmuxi $vimi"
    else
        echo "Not installing."
    fi
fi

# Install the config files to their respective places

export CFGDIR=$(pwd)

## .tmux.conf
if [ ! -f "~/.tmux.conf" ]; then
    ln -s $CFGDIR/tmux.conf ~/.tmux.conf
    code=$?
    if [ $code = 0 ]; then
        echo "Tmux config successfully linked."
    else
        echo "Error in linking tmux config: $code"
    fi
else
    echo "Tmux config already exists."
fi

## .vimrc
if [ ! -f "~/.vimrc" ]; then
    ln -s $CFGDIR/vimrc ~/.vimrc
    code=$?
    if [ $code = 0 ]; then
        echo "Vim config successfully linked."
    else
        echo "Error in linking vim config: $code"
    fi
else
    echo "Vim config already exists."
fi

## .bash_aliases
if [ ! -f "~/.bash_aliases" ]; then
    ln -s $CFGDIR/bash_aliases ~/.bash_aliases
    code=$?
    if [ $code = 0 ]; then
        echo "Bash aliases successfully linked."
    else
        echo "Error in linking Bash aliases: $code"
    fi
else
    echo "Bash aliases already exists."
fi
