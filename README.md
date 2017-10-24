# dotfiles
This repo provides quick and portable way to setup your dot environment.

Inspired from 
https://github.com/ronakg/dotfiles

# Backup first
> Make sure you back up your current dotfiles, bashrc or other shell settings before you use this.

## To use it quickly
1. git clone this repo
2. Put this text in your .bashrc file:
``` bash
[ -f ~/dotfiles/bashrc_user ] && . ~/dotfiles/bashrc_user
```

## Install Utilities if needed
``` bash
~/dotfiles/install_utils.sh
```
