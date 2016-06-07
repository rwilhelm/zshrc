function redux-actions () {
	grep -ohr 'function.*' $1 | sed 's/function //g;s/export //g' | grep -o '^\w+'
}

function redux-types () {
	grep '[A-Z]+_[A-Z]\w+' -rho $1
}

alias -g LOL="| lolcat -F 0.5"
