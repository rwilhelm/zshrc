new-sencha-app () {
	set -e
	mkdir sencha-test
	cd sencha-test
	sencha -sdk ~/Desktop/ext-5.1.1 generate app MyApp ./app
	git init .
	git add .
	git commit -a -m 'Initial commit / generated sencha app'
	cp ~/Desktop/.editorconfig .
	touch README.md
	git add README.md
	git commit README.md -m 'Added README.md'
	git add .editorconfig
	git commit .editorconfig -m 'Added .editorconfig'
	set +e
}
