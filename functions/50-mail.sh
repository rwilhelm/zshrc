function gmail () {
	fixme "set up credentials in a proper place ($0)"
	return
	#cat -- "$@" | while IFS= read -r line; do
	echo $@[3,-1] | mail -s $2 $1
}

function attach () {
	uuencode $3 $3:r | mail -s $2 $1
}
