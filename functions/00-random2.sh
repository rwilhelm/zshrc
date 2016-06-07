#
# DEFAULT OPTIONS
# OVERRIDE BUILTIN COMMANDS
# PART 2
#

# some kind of special completion on ctrl-n
# zstyle ':completion:most-recent-file:*' match-original both
# zstyle ':completion:most-recent-file:*' file-sort modification
# zstyle ':completion:most-recent-file:*' file-patterns '*:all\ files'
# zstyle ':completion:most-recent-file:*' hidden all
# zstyle ':completion:most-recent-file:*' completer _files
# zle -C most-recent-file menu-complete _generic
# bindkey "^N" most-recent-file

# dradio(){
# 	mplayer -dumpstream -dumpfile $(date +%s).ogg \
# 	http://dradio-ogg-dlf-l.akacast.akamaistream.net/7/629/135496/v1/gnl.akacast.akamaistream.net/dradio_ogg_dlf_l
# }

#function playdvd() { mplayer dvd://1 --dvd-device=$1 }

#function movie2k() { mplayer $(noglob echo $1 | urldecode.awk | grep -o 'http://[a-zA-Z0-9_-.]+.\.flv') }

alias mplayer="mpv"

DRADIO_STREAM_URL='http://dradio-ogg-dlf-l.akacast.akamaistream.net/7/629/135496/v1/gnl.akacast.akamaistream.net/dradio_ogg_dlf_l'

function dradio() {
	mpv $DRADIO_STREAM_URL
}

function dradio-rec() {
	mpv --stream-dump=~/Desktop/$(date +%s).ogg $DRADIO_STREAM_URL
}

# watch file execute
wfx() {
	while true; do
		change=$(inotifywait -e close_write,moved_to,create .)
		change=${change#./ * }
		if [ "$change" = "myfile.py" ]; then ./myfile.py; fi
	done
}

# non-blocking only
watchFile() {
	a=$(eval ./$1)
	echo $a
	while true; do
		sleep 1
		b=$(eval ./$1)
		if ! $(cmp -s =(echo $a) =(echo $b)); then
			echo
			echo $(date +'%x %X')
			echo $b
			a=$b
		fi
	done
}

function xpath() {
	unset {a-z};

	a="/html[@class=' js boxshadow opacity cssgradients svg']/body[@id='b_body']/div[@id='o_c1234800063']/div[@id='o_c1234800410']/div[@id='o_c1234800072']/div[@id='o_c1234800067']/div[@id='o_c1234800070']/div[@id='o_c1234800408']/div[@id='o_c1234800332']/div[@id='o_c1234800074']/div[@id='b_page_margins']/div[@id='b_page_wrapper']/div[@id='b_page']/div[@id='o_c1234800115']/div[@id='o_c1234801728']/div[@id='o_c1234801724']/div[@id='o_c1234801723']/div[@id='o_c1234801713']/div[@id='o_c1234801712']/div[@id='o_c1234801686']/div[@id='o_c1234801683']/div[@id='o_c1234801710']/div[@id='o_c1234801706']/div[@id='b_main']/div[@id='b_col2']/div[@id='b_col2_content']/div[@class='b_floatbox']/div[@id='o_c1234801708']/div[@id='o_c1234801701']/div[@id='o_c1234801700']/div[@class='b_toolboxes']/div[@class='b_toolbox']/div[@class='b_toolbox_content']/ul/li[@class='b_clearfix'][1]/span[@id='o_c1234801702']/a[@id='o_lnk1234801702']/span";

	b=$(echo $a | sed 's/\[[a-z0-9_@=\ '/\\\'/''/\\\''/]*\]//g');

	c=(${(s:/:)b});

  typeset -U d;
	d=($c);

	e=/${(j:/:)d};

	f=($(g=(); h=0;
		for ((i=1;i<$#c;i++)); do
			if [[ $c[$i] = $c[(($i + 1))] ]]; then
				f=$(($f + 1));
			else
				g=($g $f); f=0;
			fi
		done && echo $g ))

  g=($(
  	for ((i=1; i<$#d; i++)); do
  		for ((j=0; j<$#f; j++)); do
  		done
			echo $d[$i]\[$((f[i] + 1))\]; # span[4]
  	done
  ))

  h=/${(j:/:)g}

	echo A
	echo $a
	echo B
	echo $b
	echo C
	echo $c
	echo D
	echo $d
	echo E
	echo $e
	echo F
	echo $f
	echo G
	echo $g
	echo H
	echo $h
	echo I
	echo $i
	echo

# i=0; j=0; for ((i=1; i<$#d; i++)) { for ((j=1; j<$#f; j++)) { }; echo $d[$i]\[$f[i]\] }

}

alias _S='subl -n $PWD'

function installWhatever() {

	if [[ -f ./package.json ]]; then
		npm install
	fi

	if [[ -f ./bower.json ]]; then
		bower install
	fi

#	if [[ -f ./Makefile ]]; then
#		make
#		echo install? no? ctrl-c!; read
#		make install
#	fi

}

function gulp-watched-files() {
	find . -type f | grep -v '.*\.css|.*\.log|.*\.map|.*\.md|.DS_Store|.git|.sass-cache|bower.json|bower_components|Gulpfile.js|karma.conf.js|LICENSE|Makefile|node_modules|package.json|public/css/.*\.css|public/css/.*\.map|public/js/components/.*\.js|public/js/components/.module-cache|test|.npmrc' | wc -l
}

function 2jade() {
	pbpaste | html2jade | pbcopy && pbpaste
}

