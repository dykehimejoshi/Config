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

autoload -Uz promptinit
autoload -Uz vcs_info
promptinit

zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':vcs_info:git:*' formats '%r:%b%f'
zstyle ':vcs_info:*' enable git

# runs before each prompt
function precmd() {
    # this funky little workaround prints a blank line after each command
    precmd() { echo }
}

prompt_custom_setup() {
    # i don't know if this is better than what i had before, but this at least
    # allows the prompt the change dynamically based on e.g. whether or not
    # we're in a git repo, or if the histfile is unset
    PROMPT="%f%b[%~] %(!.%b%F{red}%m%f%b.%F{\$_prompt_color_username}%n \
%F{\$_prompt_color_hostname}%m%f%b) [%D{%H:%M:%S}]\
%(?.. [%F{\$_prompt_color_cmderror}%?%f])\$_prompt_ranger\$_prompt_get_chroot
%(!.%K{red}.)\$_prompt_histfile_active%#%f%b%k "

    RPROMPT=\$vcs_info_msg_0_
    #RPROMPT="[%D{%H:%M:%S}]"
}

# get all the variables we use in our prompt string
_prompt_get_vars () {
    _prompt_histfile_active=`test -z $HISTFILE && echo '--'`

    # find out whether the terminal supports 256 colors or not
    if $(echo "$TERM" | grep -vq 256color); then
        less_colors="yes"
    else
        less_colors=
    fi

    # define colors for different hosts
    h=$(hostname 2>/dev/null || hostnamectl hostname 2>/dev/null || cat /etc/hostname 2>/dev/null)
    # format: ( 256username 256hostname 8username 8hostname )
    using=( 219 122 5 2 ) # default
    test "$h" = "capybara"  && using=( 147 209 3 6 ) # server
    test "$h" = "amnesia"   && using=( 99  255 5 7 ) # tails usb
    test "$h" = "localhost" && using=( $using ) # termux TODO change
    ###
    if [ ! -z "$less_colors" ]; then
        export _prompt_color_username=${using[3]}
        export _prompt_color_hostname=${using[4]}
        export _prompt_color_cmderror=yellow
    else
        export _prompt_color_username=${using[1]}
        export _prompt_color_hostname=${using[2]}
        export _prompt_color_cmderror=11
    fi
    unset less_colors

    # determine whether or not we're running a shell in ranger
    if [ -n "$RANGER_LEVEL" ]; then _prompt_ranger=" (R) "; fi

    return
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
        # i recognize that this only shows is the filesystem we're in also has
        # this config repo, but     i don't really care
        is_chroot="yes"
    fi
    if [ "$is_chroot" = "yes" ]; then
        _prompt_get_chroot=" (chroot)"
    fi
    unset is_chroot
}

precmd_vcs_info() { vcs_info }
precmd_functions+=( _prompt_get_vars precmd_vcs_info )
setopt prompt_subst

prompt_themes+=( custom )

prompt custom

export _confdir=$(dirname `readlink -f $HOME/.zshrc` )

source $_confdir/aliases

# add completion for the newcd and mkcdir function aliases
# otherwise it would try to complete to files as well, which we don't want
compdef _dirs newcd
compdef _dirs mkcd

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

# If we have ~/bin or ~/.local/bin folders, add them to the path
if [ -d "$HOME/bin/" ]; then
    export PATH=$PATH:$HOME/bin
fi
if [ -d "$HOME/.local/bin/" ]; then
    export PATH=$PATH:$HOME/.local/bin
fi

# fuck microsoft
export POWERSHELL_TELEMETRY_OPTOUT=1
export POWERSHELL_CLI_TELEMETRY_OPTOUT=1
export DOTNET_TELEMETRY_OPTOUT=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# if we have any other things for zsh to source that are specific
# to one system, source them here
if [ -f "$HOME/.zsh-extras" ]; then
    source $HOME/.zsh-extras
fi
