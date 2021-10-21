# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/deya/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export SebCfgDir=$(dirname `readlink -f /home/deya/.zshrc` )

source $SebCfgDir/aliases
