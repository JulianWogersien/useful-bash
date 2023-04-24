#!/bin/sh
git clone https://github.com/coolian1337/nvim-config.git
mkdir ~/.config/nvim
cp -rf ./nvim-config/* ~/.config/nvim
rm -rfd ./nvim-config
