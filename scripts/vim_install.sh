#!/usr/bin/env bash

# Install Vundle
vundle_dir="${HOME}/.vim/bundle/Vundle.vim"
if [ ! -d "${vundle_dir}" ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git ${vundle_dir}
fi

# Install plugins
vim +PluginInstall +qall
