# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cdated"

# Don't bother with brew on Linux
if [ "$(uname)" != "Darwin" ]; then
    plugins=(git wd sudo vagrant)
else
    plugins=(git brew wd sudo vagrant)
fi

## Plugin Descriptions ##
#
# brew: add commandline completion for Homebrew on OSX
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
alias viml="vim -u NONE"
alias tmux="tmux -2"
alias mongod="mongod --config /usr/local/etc/mongod.conf"
alias paneid="tmux run 'echo #{pane_id}'"

# OS dependent aliases
if [ "$(uname)" = "Darwin" ]; then
    alias ls='ls -G'
    alias vim='mvim -v'
    export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin
    export PYTHONPATH=$PYTHONPATH:/usr/local/Cellar/opencv3/3.1.0_1/lib/python3.5/site-packages
else
    # Alias vim to 'gvim -v' only if gvim is installed
    command -v gvim >/dev/null 2>&1 && alias vim='gvim -v'
fi

# Make quick tarballs
function bak(){
    DATE=$(date +%Y_%m_%d_%H-%M)
    tar -czvf ${1%/}.$DATE.tar.gz ${1%/}
}

function baller(){
    tar -czvf ${1%/}.tar.gz ${1%/}
}

# Make source tarballs
function star(){
    VERSION=`grep -oh "Version: *.*.*" *.spec | sed 's/Version: //'`
    PROJECT=`grep -oh "Name: [[:alnum:]]*" *.spec | sed 's/Name: //'`
    tar -czvf ~/rpmbuild/SOURCES/$PROJECT-$VERSION.tar.gz .
}

function enc(){
    ENCRYPTED=${1}.enc
    openssl enc -aes-256-cbc -a -salt -in ${1} -out $ENCRYPTED

    # If all went well, destroy the original
    if [ $? -eq 0 ]; then
        rm ${1}
    fi
}

function dec(){
    DECRYPTED=${1}.dec
    openssl enc -d -aes-256-cbc -a -in ${1} -out $DECRYPTED

    # If all went well, remove irrelevent extensions
    if [ $? -eq 0 ]; then
        OUTFILE=`echo $DECRYPTED | sed 's/.enc.dec$//'`
        mv $DECRYPTED $OUTFILE
    fi
}

function activate(){
    source ${1}/bin/activate
}

function civilize(){
    # Recursively replace spaces in filenames to underscores
    find . -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;
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

#export HOMEBREW_BUILD_FROM_SOURCE=0

setopt append_history no_inc_append_history no_share_history
