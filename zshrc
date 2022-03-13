# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload -Uz promptinit
promptinit

prompt_seb_setup() {
    nl=$'\n'
    is_root=$(test "$EUID" -eq 0; echo $?)
    # directory
    pstr="${nl}%f%b[%~] "
    # username/hostname
    if [ $is_root -eq 0 ]; then
        pstr+="%b%F{red}%m%f%b"
    else
        # default colors: (name);(hostname);(exit code)
        # magenta;blue;yellow
        # or: 121;69;11
        if [ "$TERM" = "linux" ]; then
            pstr+="%B%F{green}%n %B%F{blue}%m%f%b"
        else
            pstr+="%B%F{121}%n %B%F{69}%m%f%b"
        fi
    fi
    # return code of previous command
    if [ "$TERM" = "linux" ]; then
        pstr+=" [%F{yellow}%?%f]"
    else
        pstr+=" [%F{11}%?%f]"
    fi
    # display if chrooted
    is_chroot=
    if [ -f /proc/1/mountinfo ]; then
        # if yes, more stuff to do
        for entry in $(cat /proc/1/mountinfo); do
            # we're looking for an entry for /
            if [ $(echo "$entry" | cut -d ' ' -f 4) = $(echo "$entry" | cut -d ' ' -f 5) ]; then
                # if we're here, then we're not in a chroot
                is_chroot=
                break
            else
                is_chroot="yes"
            fi
        done
    else
        # here means yes, e.g. a mounted filesystem
        is_chroot="yes"
    fi
    if [ "$is_chroot" = "yes" ]; then
        pstr+=" (chroot)"
    fi
    pstr+="${nl}"
    # root indicator (?) the $ or the #
    if [ $is_root -eq 0 ]; then
        pstr+="%K{red}%#%f%b%k "
    else
        pstr+="%# "
    fi
    PROMPT=$pstr
    RPROMPT="[%D{%H:%M:%S}]"
}

prompt_themes+=( seb )

prompt seb

export SebCfgDir=$(dirname `readlink -f $HOME/.zshrc` )

source $SebCfgDir/aliases

if [ -f "$HOME/reminders" ]; then
    if [ -s "$HOME/reminders" ]; then
        echo -e "Reminders:\n----------"
        cat $HOME/reminders
        echo "----------"
    fi
fi

if [ -f "$HOME/.zsh-extras" ]; then
    # if we have any other things for zsh to source that are specific
    # to one system, source them here
    source $HOME/.zsh-extras
fi

# Using a GPG key as an SSH key
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent
