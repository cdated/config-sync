#!/bin/sh

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# Removing OMZ .zshrc
rm ~/.zshrc

# Create all the symlinks
ln -s ${PWD}/vim ~/.vim
ln -s ${PWD}/vim/.vimrc ~/.vimrc
ln -s ${PWD}/.tmux.conf ~/.tmux.conf
ln -s ${PWD}/.zshrc ~/.zshrc
ln -s ${PWD}/zsh/cdated.zsh-theme ~/.oh-my-zsh/themes

# If zsh is install change it to the default shell
ZSH_PATH=$(whereis zsh)
if [ ! -z $ZSH_PATH ]; then
  chsh -s $ZSH_PATH
fi
