#!/bin/bash

video="$1"
width=$(ffprobe -v error -select_streams v -show_entries stream=width,height -of csv=p=0:s=x "$video" | cut -d "x" -f 1)
height=$(ffprobe -v error -select_streams v -show_entries stream=width,height -of csv=p=0:s=x "$video" | cut -d "x" -f 2)
duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$video")

multiply() {
    echo "$1 * $2" | bc -l
}

divide() {
    echo "$1 / $2" | bc -l
}

add() {
    echo "$1 + $2" | bc -l
}

split_times() {
    local total_splits
    total_splits=$(divide "$duration" 0.1 | cut -d "." -f 1)

    for (( i=0; i<total_splits; i++ )); do

        local tstart
        local tend
        local tstart_ms
        local tend_ms
        local dt_ts
        local dt_te
        tstart="$(multiply $i 0.1)"
        tend="$(add "$tstart" 0.1)"
        dt_ts=$tstart
        dt_te=$tend
        tstart="$(multiply "$tstart" 1000 | cut -d "." -f 1)"
        tend="$(multiply "$tend" 1000 | cut -d "." -f 1)"

        tstart_ms="$(multiply "$dt_ts" 1 | cut -d "." -f 2)"
        tend_ms="$(multiply "$dt_te" 1 | cut -d "." -f 2)"

        unixstart=$((tstart / 1000))
        unixend=$((tend / 1000))

        local date_start
        local date_end
        date_start=$(date -u -d "@$unixstart" +"%H:%M:%S")
        date_end=$(date -u -d "@$unixend" +"%H:%M:%S")
        date_start="$date_start.$tstart_ms"
        date_end="$date_end.$tend_ms"

        echo "start: $date_start, end: $date_end part: $i out of: $total_splits"
        ffmpeg -v quiet -y -i "$video" -vcodec copy -acodec copy -ss "$tstart" -t "$tend" -sn "tmpvid$i.webm"
    done

    echo "done splitting, now changing videos and generating an index file"

    local h_steps
    h_steps=$(divide "$height" "$total_splits")
    for (( i=0; i<total_splits; i++ )); do
        local chr
        chr=$(multiply "$h_steps" "$i")
        echo "clip $i out of $total_splits current height: $chr"
        ffmpeg -loglevel quiet -i "tmp$i.webm" -vf scale="$width:$chr tmpvid$i.webm"

        echo "file 'tmpvid$i.webm'" >> tmpvid.txt
    done

    echo "finished preprocessing and generated index file, now generating final video and then cleaning up"

    ffmpeg -f concat -safe 0 -i tmpvid.txt -c copy out.webm
    rm tmpvid*

    echo "done"
}

split_times