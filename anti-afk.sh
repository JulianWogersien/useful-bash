#!/bin/sh

while [ 1 ]; do
    sudo ydotool mousemove -x -100 -y 100
    sleep 1
    sudo ydotool mousemove -x 100 -y -100    
    sleep 1
done
