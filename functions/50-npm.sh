
GLOBAL_NPM_MODULES=$ZDOTDIR/.global-npm-module-state

function save-global-npm-module-state () {
	npm list --depth=0 -g | awk '/├──/{F="@"; print $2}' | cut -d@ -f1 > $GLOBAL_NPM_MODULES
}

function get-global-npm-module-state () {
	cat $GLOBAL_NPM_MODULES | column
}

function install-global-npm-modules () {
	echo "\e[34mThe following npm modules will be installed:\e[00m"
	get-global-npm-module-state
	echo "\e[31mPress Ctrl-C to abort.\e[00m"
	read
	npm install -g $(get-global-npm-module-state)
}
