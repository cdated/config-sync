# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="cdated"

# Don't bother with brew on Linux
if [ "$(uname)" != "Darwin" ]; then
    plugins=(git wd vagrant zsh-completions)
else
    plugins=(git brew wd vagrant zsh-completions)
fi

fpath+=~/.zfunc

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
HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt inc_append_history
setopt no_share_history


# End of lines added by compinstall
# The following lines were added by compinstall
zstyle :compinstall filename '/home/brandon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -U colors && colors

# Aliases
alias grep='grep --color=auto'
alias vi=vim
alias viml="vim -u NONE"
alias tmux="tmux -2"
alias paneid="tmux run 'echo #{pane_id}'"

# Suffix aliases, open .py and .conf with vim by default
alias -s conf=vim

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
    PROJECT=`grep -oh "Name: [[:alnum:]-]*" *.spec | sed 's/Name: //'`
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

function unrpm() {
    rpm2cpio ${1} | cpio -idmv
}

function untar() {
    tar zxvf ${1}
}

function docker_clean() {
    docker rmi --force $(docker images --filter "dangling=true" -q --no-trunc)
}

function yaml2json() {
    python -c 'import json, sys, yaml ; y=yaml.safe_load(sys.stdin.read()) ; json.dump(y, sys.stdout)'
}

export TZ=:/usr/share/zoneinfo/America/New_York

stty -ixon

LIBRARY_PATH=/opt/X11/lib:$LIBRARY_PATH

PATH=$PATH:~/.cabal/bin # Add Cabal

#export HOMEBREW_BUILD_FROM_SOURCE=0
#export CFLAGS='-W -Wall -ansi -pedantic -std=c11'

alias pretty='python -m json.tool'
alias fast="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"
alias whatsmyip="curl ipinfo.io"
alias gitclean="git reset --hard HEAD;git clean -fdx"
