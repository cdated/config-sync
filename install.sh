#!/bin/sh

# If zsh is installed change default shell to zsh
ZSH_PATH=$(command -v zsh)
if [ ! $? -eq 0 ] || [ ! -e $ZSH_PATH ]; then
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
if [ ! -d $OMZ_PATH ]; then
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
	git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
	echo "OMZ installed"
fi

# Replace theme with repo file
if [ -e $ZSH_THEME ]; then
	rm $ZSH_THEME
fi
ln -s ${PWD}/zsh/cdated.zsh-theme $ZSH_THEME
echo "cdated theme installed"

if [ -d ~/.vim ]; then
	rm -rf ~/.vim
fi
ln -s ${PWD}/vim ~/.vim
echo ".vim directory linked"

if [ -d ~/.config/nvim ]; then
	rm -rf ~/.config/nvim
fi
ln -s ${PWD}/nvim ~/.config/nvim
echo ".nvim directory linked"

if [ -d ~/.i3 ]; then
	rm -rf ~/.i3
fi
ln -s ${PWD}/i3 ~/.i3
echo ".i3 directory linked"

if [ ! -f ~/.gitconfig ]; then
	cp ${PWD}/.gitconfig ~/.gitconfig
	echo ".gitconfig linked"
fi

cp ${PWD}/.Xmodmap ~/
echo "copied xmodmap for caps->ctrl"

# Create all the symlinks
for file in .bashrc .vimrc .tmux.conf .zshrc .taskrc; do
	if [ -h ~/${file} ] || [ -e ~/${file} ]; then
		rm ~/$file
	fi
	ln -s ${PWD}/$file ~/$file
done
echo "rc files linked"

# Install fzf for fuzzy text search
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
echo "fzf installed"

git submodule update --init --recursive

git config --global user.name "Brandon T. Fields"
git config user.email "brandon@cdated.com"
git config --global core.editor "nvim"
git config --global diff.tool nvimdiff
git config --global merge.tool nvimdiff
git config --global --add difftool.prompt false

echo "Done!"
