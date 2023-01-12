
for

if [[ "$1" == "-a" ]]; then
	ls -a -r  | grep "$2"
else
	ls -r | grep "$1"
fi
