#!/bin/sh

curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

# Create all the symlinks
ln -s vim ~/.vim
ln -s vim/.vimrc ~/.vimrc
ln -s .tmux.conf ~/.tmux.conf
ln -s .zshrc ~/.zshrc
ln -s zsh/cdated.zsh-theme ~/.oh-my-zsh/themes

# If zsh is install change it to the default shell
ZSH_PATH=$(whereis zsh)
if [ ! -z $ZSH_PATH ]; then
  chsh -s $ZSH_PATH
fi
