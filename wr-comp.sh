#!/bin/bash

array_contains() {
    local array="$1[@]"
    local seeking=$2
    local in=1
    for element in "${!array}"; do
        if [[ $element == "$seeking" ]]; then
            in=0
            break
        fi
    done
    return $in
}

linesf1=()
linesf2=()
lines_out=()

file1="$1"
file2="$2"

echo " " >> "$1"
echo " " >> "$2"

while read -r line; do
    linesf1+=("$line");
done <"$file1"

while read -r line; do
    linesf2+=("$line")
done <"$file2"

# uncomment to test array_contains function
#array_contains linesf1 "200" && echo yes || echo no
#array_contains linesf1 "19" && echo yes || echo no
#array_contains linesf2 "56" && echo yes || echo no
#array_contains linesf2 "962" && echo yes || echo no

for (( i=0; i<${#linesf2[@]}; i++ )); do
    array_contains lines_out "${linesf2[$i]}" && continue || lines_out+=("${linesf2[$i]}" "\n")
done

for (( i=0; i<${#linesf1[@]}; i++ )); do
    array_contains lines_out "${linesf1[$i]}" && continue || lines_out+=("${linesf1[$i]}" "\n")
done

echo -e "${lines_out[*]}" >> "output.txt"
cat output.txt | tr -d " "

