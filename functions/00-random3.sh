#
# DEFAULT OPTIONS
# OVERRIDE BUILTIN COMMANDS
# PART 3
#

# search chrome history
function chrome-history () {
	tmp="/tmp/history-$(now s)"
	hist="/Users/$USER/Library/Application Support/Google/Chrome/Default/History"
	sql="select urls.id, urls.url, urls.title, urls.visit_count, \
	urls.typed_count, urls.last_visit_time, urls.hidden, urls.favicon_id, \
	visits.visit_time, visits.from_visit, visits.visit_duration, \
	visits.transition, visit_source.source FROM urls JOIN visits ON urls.id = \
	visits.url LEFT JOIN visit_source ON visits.id = visit_source.id;"

	cp $hist $tmp
	sqlite3 -csv $tmp "$sql"
	rm $tmp
	unset $tmp $hist $sql
}

function fixme () {
	echo -e "\e[1;32m[ \e[0;31mFIXME \e[1;32m] \e[0;00m$@"
}

function todo () {
	echo -e "\e[1;32m[ \e[0;32mTODO \e[1;32m] \e[0;00m$@"
}

function note () {
	echo -e "\e[1;32m[ \e[0;33mNOTE \e[1;32m] \e[0;00m$@"
}

# curl must be shorter
alias c='curl'

# bitcoin exchange rates
bitcoin () {
	url=https://api.coindesk.com/v1/bpi/currentprice.json
	currency=$1:u # uppercase eur or usd etc, like EUR
	curl -s $url | jq ".[].${currency}.rate_float" 2>|/dev/null | egrep '[0-9]{3}'

	url=https://blockchain.info/ticker
	curl -s $url | jq ".${currency}"
}

# tarpipe
tp () { (cd $1 && tar c .) | (cd $2 && tar xp) }

# quick edit this
e () { $(eval $EDITOR ${1:-.}) }

# echo '\e[31mbla' | copy
copy () {
	uncolor.pl | pbcopy
}

alias c="pbcopy"
alias v="pbpaste"
alias gpaste="pbpaste | perl -pe 's/\r\n|\r/\n/g'"
alias pbconvert="pbpaste | perl -pe 's/\r\n|\r/\n/g' | pbcopy"
alias pbsort="pbpaste | sort | pbcopy"
function pbxmltidy { pbpaste | tidy -xml -wrap 0 | pbcopy }

# alias make="time make"

rsync_ () {
	rsync -chavzP --stats $@
}

alias -g _ix="| curl -F 'f:1=<-' ix.io"

alias edit-env="subl ~/Desktop/env.sublime-project" // TODO

alias regexphelp="open http://www.regular-expressions.info/refrepeat.html"

# <3
# usage: goto <word> <directory>
# opens all matching files in current editor
function match () { grep -Hnr $@ | cut -d":" -f1-2 | sort -u }
function goto () { match | xargs subl -n }
function goto-func () { a="$1 ()"; match $a ~/.zsh/functions/* | xargs subl -n }
function goto-jshint () { jshint --reporter unix $1 | cut -d":" -f1-2 | uniq | xargs subl -n }
function ge () { match "$@" src | xargs subl -n }

# if [ `uname -s` -eq "Darwin" ]; then
# fi

if [[ `uname -s` == "Linux" ]]; then
	grep -q Debian /etc/motd
	if [[ $? -eq 0 ]]; then
		alias ,i="apt-get install"
		alias ,s="apt-cache search"
		alias ,r="apt-get remove"
		alias ,u="apt-get update"
		alias ,I="apt-cache show"
		alias ,l="dpkg -l"
		alias ,U="apt-get upgrade"
	fi
fi

if [[ `uname -s` == "Darwin" ]]; then
	alias ,i="brew install"
	alias ,s="brew search"
	alias ,r="brew uninstall"
	alias ,u="brew update"
	alias ,I="brew info"
	alias ,l="brew list"
	alias ,U="brew upgrade"
fi

tlds () { curl -s http://data.iana.org/TLD/tlds-alpha-by-domain.txt }

mkproj () {
	if [[ $# -eq 0 ]]; then echo "Usage $0 <project name>"; return; fi
	project_dir=~code/_drafts/$1
	mkdir $project_dir
	cd $project_dir
	cp ~etc/skel/simple-proj/{.,}*(.) .
	subl -nb .
	git init .
	git add .
	git commit -a -m 'Initial commit'
	# hub create
	# git push --set-upstream origin master
	# hub browse
}
