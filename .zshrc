# Created by newuser for 4.3.11
#Color table from: http://www.understudy.net/custom.html
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
#Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
#Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}
 
 
PROMPT="
${fg_lgreen}%n@${at_underl}%m${at_underloff}${fg_white}[${fg_cyan}%~${fg_white}]
[${fg_green}%T${fg_white}]: ${at_normal}"
 
#Set the auto completion on
autoload -U compinit
compinit
 
#Lets set some options
#setopt correctall
setopt autocd
setopt auto_resume
 
## Enables the extgended globbing features
setopt extendedglob
 
#Set some ZSH styles
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
 
HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=1000
CABAL_PATH=/home/fieldsb/.cabal/bin 
export PATH=/home/fieldsb/dev/android/android-sdk-linux_x86/tools:$CABAL_PATH:$PATH

alias baseline='cd /home/fieldsb/safdevel/Navy_Baseline_4_branch'
alias startx='ssh-agent startx'

autoload -U colors && colors
alias ls='ls --color'
export PYTHONPATH=/usr/lib/python2.7/site-packages:/opt/google-appengine-python:$PYTHONPATH

#alias emacs="emacs -nw"
alias emacs="nohup emacs > /dev/null &"
alias ij="/home/fieldsb/dev/java/ImageJ/run"
alias janus="cd /home/fieldsb/safdevel/Navy_Baseline_4_branch/src/JANUS"

export PATH=/home/fieldsb/dev/android/android-sdk-linux_x86/tools:/home/fieldsb/dev/android/android-sdk-linux_x86/platform-tools:$PATH
export CFLAGS="-Wall"

alias gofmt="gofmt -w -tabs=false -tabwidth=4"
alias nginx="cd /etc/nginx/html"
alias indent="xmlindent -w"
alias pause="mocp -P"
alias play="mocp -U"
alias next="mocp -f"
