DOALL="-A"
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
	ls "$DOALL" -R ~/ | grep "$KEYWORD"
elif [[ "$DOROOT" == "true" ]]; then
	ls "$DOALL" -R / | grep "$KEYWORD"
else
	ls "$DOALL" -R $(pwd) | grep "$KEYWORD"
fi
