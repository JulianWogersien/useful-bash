#!/bin/bash
sudo pacman -Q | sudo tee -a tmp_p.txt
cut -f1 -d' ' tmp_p.txt >> packages.txt
rm tmp_p.txt