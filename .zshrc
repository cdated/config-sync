# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cdated"

plugins=(git brew mvn wd)

## Plugin Descriptions ##
#
# brew: add commandline completion for Homebrew on OSX
#
# mvn: add commandline completion for maven
#
# wd: add aliases to 'cd DEST' on the fly
# `wd add config`
# `wd config`
#
## End Descriptions ##

source $ZSH/oh-my-zsh.sh

# Non-OMZ Configurations

# Lets set some options
# setopt correctall
setopt autocd
setopt auto_resume

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
alias vi=vim
alias tmux="tmux -2"
alias mongod="mongod --config /usr/local/etc/mongod.conf"

# OS dependent aliases
if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
    alias vim='mvim -v'
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
    export PYTHONPATH=$PYTHONPATH:/usr/local/Cellar/opencv3/3.1.0_1/lib/python3.5/site-packages
    alias pgsql='/Applications/Postgres.app/Contents/Versions/9.4/bin/psql -p5432'
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

LIBRARY_PATH=/opt/X11/lib:$LIBRARY_PATH

PATH=$PATH:~/.cabal/bin # Add Cabal
PATH=$PATH:/opt/Sencha/Cmd/6.0.0.202

#export HOMEBREW_BUILD_FROM_SOURCE=0
export GOPATH=~/Dev/Go
PATH=$PATH:$GOPATH/bin

export MONGOCLIENT='localhost'
