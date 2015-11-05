#!/bin/bash

# Create folders for temp files
mkdir -p tmp/swap tmp/undo tmp/backup nvim.old tmp/info

if [ -z "$XDG_CONFIG_HOME" ]; then
    XDG_CONFIG_HOME=~/.config
fi

# If we are not in $XDG_CONFIG_HOME/nvim, backup everything and symlink this folder to it
if [ "$(pwd)" != "$XDG_CONFIG_HOME/nvim" ]
then
    for i in $XDG_CONFIG_HOME/nvim*; do [ -e $i ] && mv $i ./nvim.old/; done
    ln -sf $(pwd) $XDG_CONFIG_HOME/nvim
fi
ln -sf $(pwd)/nvimrc $XDG_CONFIG_HOME/nvim/init.vim

# Get spellfiles
mkdir -p $XDG_CONFIG_HOME/nvim/spell
cd $XDG_CONFIG_HOME/nvim/spell
wget http://ftp.vim.org/pub/vim/runtime/spell/{de,en}.utf-8.{spl,sug}

# Get plugins
mkdir -p $XDG_CONFIG_HOME/nvim/autoload

wget -O $XDG_CONFIG_HOME/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +e $XDG_CONFIG_HOME/nvim/init.vim +qall
