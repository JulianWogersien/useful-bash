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

do_trim="true"

linesf1=()
linesf2=()
lines_out=()

file1="$1"
file2="$2"

echo " " >> "$1"
echo " " >> "$2"

for arg in "$@"; do
    if [[ "$arg" == "-t" ]]; then
        do_trim="false"
    fi
done

while read -r line; do
    linesf1+=("$line");
done <"$file1"

while read -r line; do
    linesf2+=("$line")
done <"$file2"

# uncomment to test array_contains function
# output should be yes yes no no
#array_contains (200,1,2,6,2323,5,19) "200" && echo yes || echo no
#array_contains (200,1,2,6,2323,5,19) "19" && echo yes || echo no
#array_contains (200,1,2,6,2323,5,19) "56" && echo yes || echo no
#array_contains (200,1,2,6,2323,5,19) "962" && echo yes || echo no

for (( i=0; i<${#linesf2[@]}; i++ )); do
    array_contains lines_out "${linesf2[$i]}" && continue || lines_out+=("${linesf2[$i]}" "\n")
done

for (( i=0; i<${#linesf1[@]}; i++ )); do
    array_contains lines_out "${linesf1[$i]}" && continue || lines_out+=("${linesf1[$i]}" "\n")
done

echo -e "${lines_out[*]}" >> "output.txt"
if [[ "$do_trim" == "true" ]]; then
    tr -d " " < output.txt | tee -a tm.tm
    grep -v '^[[:blank:]]*$' tm.tm >tm.tm.tmp && mv tm.tm{.tmp,}
    mv -f tm.tm output.txt
fi
