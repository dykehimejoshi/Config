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
        pstr+="%B%F{121}%n %B%F{69}%m%f%b"
    fi
    # return code of previous command
    pstr+=" [%F{11}%?%f]${nl}"
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
