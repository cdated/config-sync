#!/bin/sh

# Install OMZ if not installed
OMZ_PATH=~/.oh-my-zsh
if [ -z $OMZ_PATH ]; then
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# Replace cdated omz theme
if [ ! -z $OMZ_PATH ]; then
    rm $OMZ_PATH/themes/cdated.zsh-theme
fi
ln -s ${PWD}/zsh/cdated.zsh-theme $OMZ_PATH/themes/cdated.zsh-theme

echo "OMZ installed"

# Create all the symlinks
rm ~/.vim
ln -s ${PWD}/vim ~/.vim

rm ~/.vimrc
ln -s ${PWD}/vim/.vimrc ~/.vimrc

rm ~/.tmux.conf
ln -s ${PWD}/.tmux.conf ~/.tmux.conf

rm ~/.zshrc
ln -s ${PWD}/.zshrc ~/.zshrc

echo "Symlinked updated"

# If zsh is installed change default shell to zsh
ZSH_PATH=/bin/zsh
if [ -x $ZSH_PATH ] && [ $SHELL != $ZSH_PATH ]; then
    chsh -s $ZSH_PATH
fi

echo "Current shell set to zsh"

echo "Done!"
