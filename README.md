# useful-bash 
useful bash scripts i wrote
i will try to make them posix compliant especally the simpler ones, 
all entries here have listed wether or not they are posix compliant

## vimspector.sh 
> Posix Compliant: Yes  

this script generates a vimspector file for a project.
vimspector is a plugin for vim & neovim for debugging.
this has to be run in the root directory of your project.
you need to specify a language, since at the moment i mostly use rust the build path  
for everything but rust is ${workspaceRoot}/src/$name
you also need to specify a name as the second argument.
this supports all languages that vimspector support except legacy ones

## wr-comp.sh
> Posix Compliant: No  
> Will it be: No  
> Reason: Arrays are required and Posix doesnt have them  
> Maybe: It might be possible to replace them with delimited strings but im not doing that  

wr-comp.sh compares to given files passed as arguments and generates a new file containing
lines of both files but no double lines for example if you have a file containing  
1 
2 
3 
4 
4  
and a file containing  
1 
3 
4 
5 
4 
6  
the file generated would contain  
1 
2 
3 
4 
5 
6  
this script also strips empty lines (eg. lines containing only newlines or spaces)  
this can be disabled by passing -t after the files it will include lines containing whitespaces  

## install-basic-vim-config.sh
> Posix Compliant: Yes  

this script installs my [basic vim config](https://github.com/coolian1337/basic-vim-config)
into your home directory without making your home directory a github repo  
pass -r to the script to have it install it into /root too so you will have this config even when you need to edit something that requires root  

## pacman-get-package-list-noversion.sh  
> Posix Compliant: Yes  

This script gets all packges installed with pacman and puts them into packages.txt and removes their versions

## count-lines-sh
> Posix Compliant: Yes  

this counts lines of all files in the current directory recursively except if any file is inside a .git folder or its a README or LICENSE file  
