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

while read -r line; do
	linesf1+=("$line");
done <$file1

while read -r line; do
	linesf2+=("$line")
done <$file2

for (( i=0; i<${#linesf2[@]}; i++ )); do
	array_contains linesf1 "${linesf2[$i]}" && lines_out+=("${linesf2[$i]}") || continue
done
for (( i=0; i<${#linesf1[@]}; i++ )); do
	array_contains linesf2 "${linesf1[$i]}" && lines_out+=("${linesf1[$i]}") || continue
done

echo ${lines_out[*]} >> "output.txt"
