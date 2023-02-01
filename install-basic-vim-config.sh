#!/bin/bash
wget -P ~/ https://raw.githubusercontent.com/coolian1337/basic-vim-config/main/.vimrc
mkdir ~/.vim
mkdir ~/.vim/colors
wget -P ~/.vim/colors https://raw.githubusercontent.com/coolian1337/basic-vim-config/main/.vim/colors/molokai.vim

if [[ "$1" == "-r" ]]; then
    sudo cp ~/.vimrc /root
    sudo cp -r ~/.vim /root
fi