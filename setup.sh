#!/usr/bin/env bash

# A setup script to link the config files to the places they need to be.

# some variables to make it look a little nicer
# test for tput (usually default on linux systems, but not on termux)
if [ $(command -v tput) ]; then
    COLOR_YELLOW=`tput setaf 3`
    COLOR_GREEN=`tput setaf 2`
    COLOR_RED=`tput setaf 1`
    COLOR_RST=`tput sgr 0`
fi
# if we don't have tput, then there's not problem with regular text

# iterate through some common package managers to find which one we have
test $(command -v apt) &&    inst="apt install"
test $(command -v pacman) && inst="pacman -Syyu"
test $(command -v pkg) &&    inst="pkg install"
test $(command -v emerge) && inst="emerge --ask"

# testing vifm in place of ranger
programs="tmux vim zsh git vifm elinks"

# Ask the user if they want to install programs
echo -n "Install programs? (y/N) > "
read user_i
if $(echo $user_i | grep -Eq '^(Y|y)$') ; then
    echo -n "Install optional vifm utilities? (y/N) > "
    read vifm_i
    if $(echo $vifm_i | grep -Eq '^(Y|y)$') ; then
        # make sure (most|all) tools get installed on systems with different
        # package names
        programs+=" odt2txt p7zip unrar unzip jq mpv"
        if   $(command -v pkg); then
            programs+=" transmission-gtk poppler zip exiftool"
        elif $(command -v apt); then
            progams+=" poppler-utils transmission-cli ziptool atool highlight"
        elif $(command -v pacman); then
            programs+=" poppler transmission-cli perl-image-exiftool atool"
            programs+=" highlight"
        elif $(command -v emerge); then
            # todo (i don't really use gentoo)
        fi
    fi
    /usr/bin/env sh -c "$(which sudo) $inst $programs"
else
    echo "Not installing."
fi

# Install the config files to their respective places

install_config () {
    if [ ! -f "$1" ]; then
        mkdir -p "$(dirname "$1")"
        ln -s $(pwd)/$2 $1
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
#install_config "$HOME/.config/ranger/rc.conf" "rangerrc"

## vifm
install_config "$HOME/.config/vifm/vifmrc" "vifmrc"

## elinks.conf
install_config "$HOME/.elinks/elinks.conf" "elinks.conf"
