
linesf1=()
linesf2=()
linestoadd=()

file1="$1"
file2="$2"

while read -r line; do
		linesf1+=("$line");
done <$file1

while read -r line; do
		linesf2+=("$line")
done <$file2

for i in "$(linesf1[@])"
do
	is_in_file="0"
	for j in "$(linesf2[@])"
	do
		if [ "$j" = "$i" ]; then
			is_in_file="1"
		fi
	done

	if [ "$is_in_file" = "0" ]; then
		linestoadd+=("$i")
	fi
done

linesf1+=$linestoadd

echo ${#linesf1[@]} >> "output.txt"
