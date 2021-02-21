#!/bin/bash

# A setup script to link the config files to the places they need to be.
# Assumes files have been cloned into ~/Config/


if [ ! -f "~/.tmux.conf" ]; then
    ln -s ~/Config/tmux.conf ~/.tmux.conf
    code=$?
    if [ -z $code ]; then
        echo "Tmux config successfully linked."
    else
        echo "Error in linking tmux config: $code"
    fi
else
    echo "Tmux config already linked."
fi

if [ ! -f "~/.vimrc" ]; then
    ln -s ~/Config/vimrc ~/.vimrc
    code=$?
    if [ -z $code ]; then
        echo "Vim config successfully linked."
    else
        echo "Error in linking vim config: $code"
    fi
else
    echo "Vim config already linked."
fi
