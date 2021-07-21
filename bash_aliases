# Bash Aliases

# Navigating directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ..5='cd ../../../../..'
alias ..6='cd ../../../../../..'
alias lgr='ls | grep --color=auto'
alias llgr='ls -l | grep --color=auto'
alias findinfile='grep -iRl --color=auto'
alias la='ls -a'
alias lah='ls -lah'
alias lh='ls -lh'
alias l='ls'
alias ll='ls -la'

# WINE aliases
alias cdcdir='cd ~/.wine/drive_c/'
alias wine64='WINEPREFIX=$HOME/.wine64 wine64'

# Package manager
if [ ! -z $(which apt-get) ]; then
    # if apt-get is installed
    alias agi='sudo apt-get install -y'
    alias acs='apt-cache search'
    alias acshow='apt-cache show'
    alias agr='sudo apt-get remove'
    alias update='sudo echo "--- update" && sudo apt-get update && echo "--- upgrade" && sudo apt-get upgrade -y && echo "--- autoremove" && sudo apt autoremove -y'
fi

if [ ! -z $(which pacman) ]; then
    # if pacman is installed
    alias paci='sudo pacman -Sy'
    alias pacs='pacman -Q'
    alias pacshow='pacman -Qi'
    alias pacr='sudo pacman -R'
    alias update='sudo pacman -Syu'
fi

if [ ! -z $(which yay) ]; then
    # if yay is installed
    alias yayi='yay -S'
    alias yays='yay -Q'
    alias yayshow='yay -Qi'
    alias yayr='yay -R'
    # Should overwrite the `update' alias from pacman if installed
    alias update='sudo echo "--- Updating" && yay -Syu'
fi

# Administration
alias _='sudo'
alias _i='sudo -i'
alias _s='sudo -s'
alias chkdu='df -h | head -n 1 && df -h | grep data-root --color=none'
alias dd='dd status=progress'
alias rm='rm -i'

# Less Configuration
LESS="-f -g -i -J -M -q -R -S -w -x4 $LESS"; export LESS
## -f: forcefully open binary files (no warning)
## -g: highlight occurences of a search
## -i: smart-ignore casing in searches
## -J: show status column
## -M: very verbose prompt
## -q: no terminal bell
## -R: only ANSI color esc
## -S: causes longer lines to be truncated rather than wrapped
## -w: highlights the newest line after forward movement of a new page
## -x4: sets tabstop to 4 spaces

# Python
alias py='python3'
alias py3='python3'
alias mkvenv='python3 -m venv venv'
alias govenv='. venv/bin/activate'
alias byevenv='deactivate'
alias serve='python3 -m http.server'

# Misc
alias tma='tmux attach'
alias qemu='qemu-system-x86_64'
alias qmu='qemu-system-x86_64'
alias rmsyncconflicts='for line in $(find ~ -name "*sync-conflict*"); do echo $line; rm "$line"; done'
alias findsyncconflicts='find ~ -name "*sync-conflict*"'
alias getdevs="ls /dev/sd? ; echo ; ls /dev/sd??"
alias mapscii='telnet mapscii.me' # https://github.com/rastapasta/mapscii
hex () { xxd "$1" | less; }

# Setting the prompt
PS1='\n\[\033[00;00m\][\w] \[\033[01;35m\]\u \[\033[01;34m\]\h \n\[\033[00m\]\$ '
