#!bash

set -x

echo -e "Installing FZF bash if not already installed"

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
