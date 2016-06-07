alias _i="pacaur -S"
alias _s="pacaur -Ss"
alias _u="pacaur -Syu"
alias _r="pacaur -R"

NOTATIONAL_DATA=$HOME/local/notes/Notational\ Data

function nv () {
	grep -ir $1 $NOTATIONAL_DATA
}

function ext1-rsync () {
	sudo rsync -av --no-p --chown=$USER:$USER $@
}

alias rsync-ext1=ext1-rsync

#alias pbcopy='xsel --clipboard --input'
#alias pbpaste='xsel --clipboard --output'

function winfo(){
	xprop | awk '
		/^WM_CLASS/ {
		  sub(/.* =/, "instance:");
			sub(/,/, "\nclass:");
			print;
		}
		/^WM_NAME/ {
		  sub(/.* =/, "title:");
			print;
		}'
}

xrandr-auto() {
	xrandr --output $2 --auto --primary --output $1 --auto --above $2
}
