#!/usr/bin/env bash

# A setup script to link the config files to the places they need to be.

# optionally 
rem_existing_files=

print_help () {
    echo -e \
"Usage:
    $0 [-r | --remove] [-h | --help]

    -r | --remove   choose to interactively remove files when they already exist during setup
                    and aren't links
    -h | --help     show this help"
    exit 0
}

case "$1" in
    -h | --help) print_help;;
    -r | --remove) rem_existing_files=1;;
esac

test -n "$rem_existing_files" && echo "Interactively removing conflicting files..."

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
test $(command -v guix) &&   inst="guix install"

programs="tmux neovim zsh git ranger elinks jq"
# TODO: install rust programs from cargo (mprocs, exa, sccache, etc)

# Ask the user if they want to install programs
echo -en "Install programs?\n  $programs\n(y/N) > "
read user_i
if $(echo $user_i | grep -Eq '^(Y|y)$') ; then
    echo -n "Install optional ranger utilities?"
    # make sure (most|all) tools get installed on systems with different
    # package names
    toadd+="tree odt2txt p7zip unrar unzip mpv imagemagick"
    if   [ $(command -v pkg) ]; then
        toadd+=" transmission-gtk poppler zip exiftool"
    elif [ $(command -v apt) ]; then
        toadd+=" poppler-utils transmission-cli ziptool atool highlight"
    elif [ $(command -v pacman) ]; then
        toadd+=" poppler transmission-cli perl-image-exiftool atool w3m"
        toadd+=" highlight ffmpegthumbnailer libcaca mediainfo python-chardet"
    elif [ $(command -v emerge) ]; then
        :
        # todo (i don't really use gentoo)
    elif [ $(command -v guix) ]; then
        :
        # todo
    fi
    echo -en "\n  $toadd\n(y/N) > "
    read cli_fm
    if $(echo $clifm_i | grep -Eq '^(Y|y)$') ; then
        programs+=" $toadd"
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
            test -n "$rem_existing_files" && \
                rm -i "$1" && install_config "$1" "$2"
        fi
    else
        echo "$COLOR_YELLOW[~] $1 already exists.$COLOR_RST"
    fi
}

## .tmux.conf
install_config "$HOME/.tmux.conf" "tmux.conf"

## .vimrc
install_config "$HOME/.vimrc" "vimrc"

## init.vim
install_config "$HOME/.config/nvim/init.vim" "nvimrc"

### neovim plugin config
install_config "$HOME/.config/nvim/lua/plugins.lua" "nvim.plugins"

## .bash_aliases
install_config "$HOME/.bash_aliases" "bash_aliases"

## .gdbinit
install_config "$HOME/.gdbinit" "gdbinit"

## .radare2rc
install_config "$HOME/.radare2rc" "radare2rc"

## rizinrc
install_config "$HOME/.rizinrc" "rizinrc"

## zshrc
install_config "$HOME/.zshrc" "zshrc"

## i3config
install_config "$HOME/.config/i3/config" "i3config"

## polybar.ini
install_config "$HOME/.config/polybar/config.ini" "polybar.ini"

### launch.sh
install_config "$HOME/.config/polybar/launch.sh" "polybar.sh"

## rangerrc
install_config "$HOME/.config/ranger/rc.conf" "rangerrc"

### ranger's rifle.conf
install_config "$HOME/.config/ranger/rifle.conf" "ranger.rifle"

## vifm
install_config "$HOME/.config/vifm/vifmrc" "vifmrc"

## elinks.conf
install_config "$HOME/.elinks/elinks.conf" "elinks.conf"

## helix config.toml
install_config "$HOME/.config/helix/config.toml" "helix.toml"

## kakoune
install_config "$HOME/.config/kak/kakrc" "kakrc"

## kitty.conf
install_config "$HOME/.config/kitty/kitty.conf" "kitty.conf"
