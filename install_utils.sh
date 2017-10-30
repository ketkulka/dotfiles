#!/bin/bash

set -x

echo -e "Installing FZF bash if not already installed"

if [ ! -f ~/.fzf/install ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi


echo -e "Enter sudo passed if asked"
sudo apt-get install tmux

ln -s $HOME/.vimrc $HOME/dotfiles/vim/vimrc
ln -s $HOME/.vim $HOME/dotfiles/vim
ln -s $HOME/.tmux.conf $HOME/dotfiles/tmux/tmux.conf
ln -s $HOME/.tmux $HOME/dotfiles/tmux
