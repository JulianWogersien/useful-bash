DOALL=""
DOHOME="false"
DOROOT="false"
KEYWORD=""

for arg in "$@"
do
	if [[ "$arg" == "-a" ]]; then
		DOALL="-a"
	elif [[ "$arg" == "-r" ]]; then
		DOROOT="true"
	elif [[ "$arg" == "-h" ]]; then
		DOHOME="true"
	else
		KEYWORD="$arg"
	fi
done

if [[ "$DOHOME" == "true" ]]; then
	ls "$DOALL" -r ~/ | grep "$KEYWORD"
elif [[ "$DOROOT" == "true" ]]; then
	ls "$DOALL" -r / | grep "$KEYWORD"
else
	echo 'ls "$DOALL" -r $(pwd) | grep "$KEYWORD"'
fi
