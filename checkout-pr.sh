#!/bin/sh

if [ "$#" -eq 0 ]; then
    echo "no arguments provided"
    exit(1)
elif [ "$#" -eq 1 ]; then
    git fetch origin pull/"$1"/head:pr
    git checkout pr
else
    git fetch origin pull/"$1"/head:"$2"
    git checkout "$2"
fi
