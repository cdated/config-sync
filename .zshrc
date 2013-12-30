# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cdated"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# Non-OMZ Configurations

# Use vim modes and use right prompt to display mode
function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-N-}/(main|viins)/-I-}"
    RPS2=$RPS1
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Set the auto completion on
autoload -U compinit
compinit

# Lets set some options
# setopt correctall
setopt autocd
setopt auto_resume
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

## Enables the extgended globbing features
setopt extendedglob

# Set some ZSH styles
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=1000

# End of lines added by compinstall
autoload -U colors && colors

# Aliases
alias grep='grep --color=auto'
alias watcher='watch -d -n1 ls -aslth'
alias vi=vim
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

alias tmux="tmux -2"

alias gofmt="gofmt -w -tabs=false -tabwidth=4"
alias indent="xmlindent -w"

alias cgrep="LANG=C grep"

# OS dependent aliases
if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
    alias vim='mvim -v'
else
    alias ls='ls --color=auto'
fi

# Make quick tarballs
function bak(){
        DATE=$(date +%Y_%m_%d_%H-%M)
                tar -czvf ${1%/}.$DATE.tar.gz ${1%/}
}

export TZ=:/usr/share/zoneinfo/America/New_York
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_PAPER="en_US.UTF-8"
LC_NAME="en_US.UTF-8"
LC_ADDRESS="en_US.UTF-8"
LC_TELEPHONE="en_US.UTF-8"
LC_MEASUREMENT="en_US.UTF-8"
LC_IDENTIFICATION="en_US.UTF-8"
LC_ALL=

stty -ixon
