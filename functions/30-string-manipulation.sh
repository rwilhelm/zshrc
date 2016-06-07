
shuffle () {
	$(whence -p perl) -ne 'print rand() . "\t$_"' $@ | sort -nk1 | cut -f 2
}
