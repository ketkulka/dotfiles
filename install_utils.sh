#!/bin/bash

set -x

echo -e "Installing FZF bash if not already installed"

if [ ! -f ~/.fzf/install ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi


echo -e "Enter sudo passed if asked"
sudo apt-get install tmux cscope ctags

ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf 
ln -s $HOME/dotfiles/tmux $HOME/.tmux 
ln -s $HOME/dotfiles/gitconfig $HOME/.gitconfig
