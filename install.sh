#!/bin/sh

# Create all the symlinks
ln -s vim ~/.vim
ln -s vim/.vimrc ~/.vimrc
ln -s .tmux.conf ~/.tmux.conf
ln -s .zshrc ~/.zshrc

# If zsh is install change it to the default shell
ZSH_PATH=$(whereis zsh)
if [ ! -z $ZSH_PATH ]; then
  chsh -s $ZSH_PATH
fi
