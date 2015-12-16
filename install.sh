#!/bin/sh

# If zsh is installed change default shell to zsh
ZSH_PATH=/bin/zsh
if [[ ! -a $ZSH_PATH ]]; then
    echo "Please install zsh first"
    exit 1
fi

if [ -x $ZSH_PATH ] && [ $SHELL != $ZSH_PATH ]; then
    chsh -s $ZSH_PATH
fi

echo "Current shell set to zsh"

# Install OMZ if not installed
OMZ_PATH=~/.oh-my-zsh
ZSH_THEME=$OMZ_PATH/themes/cdated.zsh-theme

# Install OMZ if not found
if [[ ! -d $OMZ_PATH ]]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
    echo "OMZ installed"
fi

# Replace theme with repo file
if [[ -a $ZSH_THEME ]]; then
    rm $ZSH_THEME
fi
ln -s ${PWD}/zsh/cdated.zsh-theme $ZSH_THEME
echo "cdated theme installed"

if [[ -d ~/.vim ]]; then
    rm -rf ~/.vim
fi
ln -s ${PWD}/vim ~/.vim
echo ".vim directory linked"

# Create all the symlinks
for file in .vimrc .tmux.conf .zshrc
do
    if [[ -h ~/${file} ]] || [[ -a ~/${file} ]]; then
        rm ~/$file
    fi
    ln -s ${PWD}/$file ~/$file
done
echo "rc files linked"

cd vim
git submodule init
git submodule update

echo "Done!"
