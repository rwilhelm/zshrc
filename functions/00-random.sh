#
# DEFAULT OPTIONS
# OVERRIDE BUILTIN COMMANDS
# export RANDOM_SH_STARTTIME=$(/usr/local/bin/python3 -c 'import datetime; print((datetime.datetime.now() - datetime.datetime(1970, 1, 1)).total_seconds())')


# function man() {
#   # env \
#   # LESS_TERMCAP_mb=$(printf "\e[31m") \
#   # LESS_TERMCAP_md=$(printf "\e[32m") \
#   # LESS_TERMCAP_me=$(printf "\e[33m") \
#   # LESS_TERMCAP_se=$(printf "\e[34m") \
#   # LESS_TERMCAP_so=$(printf "\e[35m") \
#   # LESS_TERMCAP_ue=$(printf "\e[36m") \
#   # LESS_TERMCAP_us=$(printf "\e[37m") \
#   # man "$@"

#   LESS_TERMCAP_mb=$'\E[01;31m' \
#   LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#   LESS_TERMCAP_me=$'\E[0m' \
#   LESS_TERMCAP_se=$'\E[0m' \
#   LESS_TERMCAP_so=$'\E[38;33;246m' \
#   LESS_TERMCAP_ue=$'\E[0m' \
#   LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#   man "$@"

# }

epoch () {
  python -c 'import datetime; print((datetime.datetime.now() - datetime.datetime(1970, 1, 1)).total_seconds())'
}

tdiff () {
  # $1: start time
  # $2: end time
  python -c "print(round(($2-$1)/60, 2))"
}

function tomato () {
  a=${1:=25}; shift
  b=${1:=5}; shift
  while :; do
    local t0=$(epoch)
    echo "$t0 [work,$a] $@" | tee -a ~/.tomato.log
    say "work $a minutes"
    sleep $(($a*60))
    echo "$t0 [play,$b] $@ $(tdiff $t0 $(epoch)) minutes" | tee -a ~/.tomato.log
    say "play $b minutes"
    sleep $(($b*60))
  done
}

work () {
  local log=~/.work.log
  local t0=$(epoch)
  echo "$(date +%F\ %X) $t0 $@" >> $log
  tail -1 $log
  read
  echo "$(date +%F\ %X) $(epoch) $@ [END $(tdiff $t0 $(epoch))]" >> $log
  tail -1 $log
}

function port () { lsof -P -i:$1 }

function light () {
  cd ~/Applications/light-table-core-2/deploy
  export LT_HOME=$PWD
  ./light $@
}

# [[ $UID == 0 ]] && return # skip the rest if we are root

# usage: cm octal [.|/]
function cm () {
  {} always { zargs -- **/*($2^f:$1:) -- chmod $1 }
}

# usage: co user group [.|/]
function co () {
  {} always { zargs -- **/*($3^u:$1:,$3^g:$2:) -- chown $1:$2 }
}

# search stuff in central metadata store (like spotlight)
# usage: m <FILTER> [<FILTER> ...]
# evals to `mdfind -name git -name pdf`
function m() {
  unset a
  for i in $@; do
    a=($a -name $i)
  done
  eval mdfind $a
}

# search stuff in pwd
# usage: f <FILTER> [<FILTER> ...]
# evals to `find . -name '*git*' -and -name '*pdf*'`
function f() {
  a=()
  s=""
  for i in $@; do
    a=($a "-name '*${i}*'")
  done
  for i in $a[1,-2]; do
    s="$s $i -and"
  done
  s="$s $a[-1]"
  eval find .$s
}

# grep filter
# usage: gf <FILTER> [<FILTER> ...]
# evals to `grep 'git' | grep 'pdf'`
# function gf() {
#   a=()
#   s=""
#   for i in $@; do
#     a=($a "'${i}'")
#   done
#   for i in $a[1,-2]; do
#     s="$s | grep '${i}'"
#   done
#   s="$s $a[-1]"
#   echo eval grep$s
# }

# search stuff in history
# usage: h <FILTER> [<FILTER> ...]
# evals to `history 1 | grep -i git | grep -i pdf`
function h() {
  a=()
  s=""
  for i in $@; do
    a=($a "| grep -i ${i}")
  done
  eval history 1 $a
}

hh () {
  h $@ | sed 's/[0-9 ]*//' | sort -u
}

function roman() {
  ruby -r 'roman-numerals' -e "puts \"$*\".split.map { |x| RomanNumerals.to_roman(x.to_i) }.join \" \""
}

function 7zpw() {
  pw=$(pwgen -c -n -s -B -1 16)
  echo $pw
  filename=$1.7z; shift
  7z a -mx1 -mhe=on -p${pw} ${filename} $@
  echo $pw | pbcopy
}

function gettpw() {
  pw=$(pwgen -c -n -s -B -1 16)
  filename=$1.7z; shift
  7z a -mx1 -mhe=on -p${pw} ${filename} $@
  gett $filename
  echo $pw | pbcopy
}

function arte() {
  echo $1 | sed 's,de/videos,de/do_delegate/videos,;s/.html/,view,asPlayerXml.xml/' | xargs curl -s
}

function arte2() {
   #curl -s $1 | awk '/embed src/' | urldecode.awk | grep -o 'http[a-zA-Z0-9.,:/_?=-]+asPlayerXml.xml' | xargs curl -s | grep -o 'http[a-zA-Z0-9.,:/_?=-]+xml' | xargs curl -s | grep hd | grep DE | grep 'rtmp[a-zA-Z0-9.,:/_?=-]HQ_DE[a-zA-Z0-9.,:/_?=-]+'

  curl -s $1 | awk '/embed src/' | urldecode.awk | grep -o 'http[a-zA-Z0-9.,:/_?=-]+asPlayerXml.xml' | xargs curl -s | grep -o 'http[a-zA-Z0-9.,:/_?=-]+xml' | xargs curl -s | grep '(hd|HQ|800)' | grep DE | grep -o 'rtmp[a-zA-Z0-9.,:/_?=-]+' | xargs -I {} rtmpdump -r {} -o toete_zuerst.flv
}

function now() {
  # now [Y] [h|m|s] - / /
  if [[ $1 == "Y" ]]; then
    shift
    y="%Y"
  else
    y="%y"
  fi

  case $1 in
    h) shift; date +$y${+3:-$1}%m${+3:-$1}%d${+2:-$1}%H ;; # to the hour
    m) shift; date +$y${+3:-$1}%m${+3:-$1}%d${+2:-$1}%H$1%M ;; # to the minute
    s) shift; date +$y${+3:-$1}%m${+3:-$1}%d${+2:-$1}%H$1%M$1%S ;; # to the second
    *) date +${y}${+3:-$1}%m${+3:-$1}%d ;; # just the date
  esac
}

function zrecompile() {
  # https://bbs.archlinux.org/viewtopic.php?id=37245
  autoload -U zrecompile
  zrecompile -p $ZSHRC $ZDOTDIR/.zcompdump
  source $ZDOTDIR/.zshrc
}

function fzf-file-widget() {
  LBUFFER+=$(
      find * -path '*/\\.*' -prune \
      -o -type f -print \
      -o -type l -print 2> /dev/null | fzf)
  zle redisplay
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

function oo () {
  #t=~/.local/var/tmp/$(now Y '' / /)${1/^/_${1}}
  t=~/.local/var/tmp/$(now Y '' / /)
  mkdir $t && cd $t || echo '\e[0;31mno! :)'
}

function oO () {
  today=~/.local/var/tmp/$(now Y '' / /)
  [[ ! -z $1 ]] && cd $today/*/*$1*(/om[1]) || cd $today/*(/om[1])
}

function oOrm () {
  rmdsstore ~/local/tmp NUL
  rmdir ~/local/tmp/*/*(/) NUL
  tree -C -L 3 ~/local/tmp/$(now Y '' / /)
}

# alias t="tree -C"

renamePwd() {
  mv $PWD ${PWD:h}/$1 && cd .
}

rmPwd() {
  cd .. && trash $OLDPWD
}

mvPwdToDate() {
  dir=../$(zstat -F '%H%M%S' +ctime $PWD)
  mkdir $dir && mv $PWD $dir && cd .
}

weather() {
  a=($(ls -1 ~/.condrc.* | awk -F. '{print $NF}'))
  if [[ ${a[(i)l]} -le ${#a} ]]; then
    loc=$1; shift
    ln -sf ~/.condrc.$loc ~/.condrc
  fi
  wu $@
}

function trim-image() {
  [[ $# -ne 1 ]] && echo "argument missing" && return 1
  convert $1 -trim $1
  # convert $1 -bordercolor black -border 16 $1
}

revive () {
  ps caux | grep $1 | awk '{print $2}' | while read i; do
    kill -CONT $i
  done
}

update-all () {
  echo -e '\n=== \e[0;34mbrew\e[0;0m\n'
  update-brew
  # brew doctor
  echo -e '\n=== \e[0;33mnode\e[0;0m\n'
  update-node
  echo -e '\n=== \e[0;33mnpm\e[0;0m\n'
  npm update -g
  echo -e '\n=== \e[0;31mgem\e[0;0m\n'
  gem update
  echo -e '\n=== \e[0;36mosx\e[0;0m\n'
  softwareupdate -aiv
}

searchall () {
  echo -e '\n=== \e[0;33mnpm\e[0;0m\n'
  npm --loglevel silent --long search $1
  echo -e '\n=== \e[0;34mhomebrew\e[0;0m\n'
  brew search $1
  echo -e '\n=== \e[0;34mhomebrew cask\e[0;0m\n'
  cask search $1
  echo -e '\n=== \e[0;31mruby gems\e[0;0m\n'
  gem search --quiet $1
  echo -e '\n=== \e[0;32mpython pypi\e[0;0m\n'
  pip3 search $1
  echo -e '\n=== \e[0;35mcabal\e[0;0m\n'
  cabal list $1
  # TODO perlbrew / cpan / cpanm
  echo
}


# --------------------------------------------------


#alias -g @MP3URL="| egrep -o 'http://[0-9a-z/\._-]+\.mp3'"
#alias -g @QL='|while read -r line; do echo \"$line\"; done' # QUOTE LINES
#alias -g @RM='|while read -r line; do rm "$line"; done' # REMOVE FILE PER LINE
#alias -g @WG="|while IFS= read -r line; do wget -nv \$line; done"
#alias -g @S="| festival --tts"
#alias -g GFX="(ATI|AMD|Graphics|Upstream|TyMCE|AGPM|Radeon)"

function 43pws() { for i ({3..43}) echo $(pwgen -c -n -s -B -1 -v 8).$(pwgen -c -n -s -B -1 3) }
function b() { go build ${1:-*}.go }
function cdg() {$(gem env | awk '/GEM PATH/{getline a; gsub(/[ ]+- /,"",a); printf "%s/%s\n",a,"gems"}')}
#function du-rootfs() { sudo du -sch ^(home|swapfile|var|mnt|media|boot|proc|dev) }
#function dups-to-folder() { duff -r [A-Za-Z]* | grep ' 2.m..$' | while read -r a; do mv $a ~/Desktop/asdf; done }
#function fc-ttf() { fc-list :fontformat=TrueType -f "%{family}\n" | sort -u | grep -i $1 }
#function gitinit() { git init . && git add $@ && git commit -a -m 'initial commit' }
#function google() { $BROWSER "http://www.google.de/search?q=${@}" }
#function h() { history 1 | grep -i ${1:-.} }
#function ipaddr() { networksetup -getinfo Wi-Fi  | awk '/^IP address/{print $3}' }
#function m() { $BROWSER =(markdown $1) }

function spoof-mac-address() {
  a=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
  echo "$(ifconfig en0 ether | awk '/ether/{print $2}') -> $a"
  sudo ifconfig en0 ether $a
}

#function netinfo() { networksetup -getinfo Wi-Fi }
#function nzbfix() { par2repair *par2 && unp $@ }
#function ping() { $(which -p ping) -c3 $1 | grep '\d{3}.\d{3}' }
#function q() { echo $* $(<&0) }
#function rna() { rnws $@ && rnlc $@ }
#function rnlc() { for i ($@) mv $i $(echo $i | tr 'A-Z' 'a-z') }
#function rnws() { for i ($@) mv $i $(echo $i | sed 's/ //g') }
#function router() { networksetup -getinfo Wi-Fi  | awk '/^Router/{print $2}' }
#function s() { slocate -i -A $@ }
#function say() { echo $@ | festival --tts }
#function swr2() { echo $1 | grep -o 'rtmp://[a-zA-Z0-9_-=]+mp3' | urldecode.awk | sed 's/&PlugInSWR.sURL1=//' }
#function uni() { cd ~/Documents/Uni/$1 && (urxvt -e vim -p *.tex &) && (mupdf $1.pdf &) }

## strip last to cols
## awk '{for (i=1; i<=NF-1; i++) printf((i==NF-1)?"%s\n":"%s ",$i)}' }

## https://coderwall.com/p/hlyywa
#function mac-battery() {
# ioreg -n AppleSmartBattery -r \
#   | awk '$1~/Capacity/{c[$1]=$3} END{OFMT="%.2f%%"; max=c["\"MaxCapacity\""]; print (max>0? 100*c["\"CurrentCapacity\""]/max: "?")}'
# ioreg -n AppleSmartBattery -r \
#   | awk '$1~/ExternalConnected/{gsub("Yes", "+");gsub("No", "-"); print substr($0, length, 1)}'
#}

# FIXME
#function mksudo() {
# sudo=(rmmod modprobe netcfg shutdown reboot halt dmesg pacman)
# if [[ ! $(whoami) == "root" ]]; then
#   for x in $sudo; do
#     if [[ -x $(whence $x) ]]; then
#       echo "alias $x=\"sudo $x\""
#       alias $x="sudo $x"
#     fi
#   done
# fi
#}

# FIXME
#function mknoglob() {
# noglob=(pacman find rake clive)
# for x in $noglob; do
#   echo alias $x="noglob $(whence $x)"
#   alias $x="noglob $(whence $x)"
# done
#}

# FIXME
#function vim-sudo() {
# if [[ $#@ == 1 ]] && [[ ! -w $1 ]]; then
#   echo sudo vim $1
# else
#   echo vim $1
# fi
#}

#function sort_repositories() {
# for i in **/.git(/); do
#   if test -f $i/FETCH_HEAD; then
#     repo=$(awk '{gsub("(http[s]://|git://)", ""); print $NF; exit}' $i/FETCH_HEAD)
#     if [[ -n $repo ]]; then
#       mkdir -p $1/${repo:h}
#       mv ${i:h} $1/${repo:h}/${repo:t}
#     fi
#   fi
# done
# #for i in **/.hg(/); do
# # if test -f $i/hgrc; then
# #   repo=$(awk '/default/{next;gsub("http[s]://", ""); print $NF; exit}' $i/hgrc)
# #   if [[ -n $repo ]]; then
# #     echo mkdir -p $1/${repo:h}
# #     echo mv ${i:h} $1/${repo:h}/${repo:t}
# #   fi
# # fi
# #done
#}

#function find_repositories() {
# for i in **/.git(/); do echo ${i:r}; done
#}

#function update_repositories() {
# for i in **/.git(/); do cd ${i:r}; pwd; git pull; echo; done
#}

#function print-random-bars() {
# a=( $(repeat 43 echo 0) )
# for i in {1..$#a}; do
#   a[$i]=$RANDOM[1,2];
#   echo $(repeat $a[$i] echo -n _)
# done
#}

#function itunes-small-albums() {
# for i in */*(/); do
#   a=$(ls -1 $i | wc -l | grep -o '\d+')
#   if [[ $a -le 5 ]]; then
#     echo -n "$a "; repeat $a; do
#       echo -n "_"
#     done
#     echo "\t${i:t}"
#     sleep 0.1
#   fi
# done
#} # itunes albums with less than n items

#function transfer-to-sdb() {
# if [[ -d /mnt/sdb1/Backups ]] && [[ -d /mnt/sdb1/Archive ]]; then
#   rsync -av --remove-source-files ~/Backups /mnt/sdb
#   rsync -av --remove-source-files ~/Archive /mnt/sdb
# else
#   echo "No. Sorry."
#   return
# fi
#}

# finds stuff by concatenating -name statements to mdfind

# finds stuff by concatenating -and statements to find

# filter zsh history by multiple keywords

#function are() {
# if [[ $1 == "-d" ]]; then local d="-d"; shift; fi
# if [[ $1 == "-y" ]]; then local y="&year[4] "; shift; fi
# arename $d -t "&artist/${y}&album/&tracknumber - &tracktitle" -p /mnt/hd154ui/Music $@
#}

#function 7zpw() {
# echo -n "Enter password: "; read PW
# echo -n "Enter filename: "; read F
# 7z a -mx1 -mhe=on -p${PW} ${F}.7z $@
#}

#function filmstarts() {
# for i in $@; do
#   google site:filmstarts.de+`echo $i | sed 's/\.[0-9]*[p]*\..*//; s/\./+/g'`
# done
#} # search filmstarts via google

#function kb() {
# case $1 in
#   query) setxkbmap -query | awk '/layout/{print $2}' ;;
#   set) setxkbmap -layout $2 -option ctrl:nocaps ;;
# esac
#}

#function jekyll-new() {
#  p=$(now Y -)-${${1:l}// /-}.${2}
#  test -z $1 && echo "arg needed"; return
#  echo "---\n layout: post\n title: "$1"\n description: ""\n category:\n tags:\n ---\n\n" >> $p
#  vim $p
#}

##function newyfm() {
##  # http://www.codeography.com/2010/02/20/making-vim-play-nice-with-jekylls-yaml-front-matter.html
##
##  echo $@ | grep -q list && layout=list || layout=default
##  title=$(echo $1:r | sed -E "s/-/ /g; s/(\b)([a-z])/\u\2/g")
##  echo $PWD | grep -iqw posts && filename=$(now Y -)-$1 || filename=$1
##  test -f $filename && echo "Failure: $filename exists" && return 1
##
##  cat << END > $filename
##---
##layout: $layout
##title: $title
##---
##
##
##END
##  vim $filename +
##} # FIXME

#function dump-current-state() {
# d=~/$(now m - /)
# mkdir $d
# bdmesg > $d/bdmesg.txt
# dmesg > $d/dmesg.txt
# ioreg | grep ATY > $d/ioreg-ATY.txt
#}

#function rm_if_unpacked() {
# for d in *(/); do
#   f=
#   #echo $f
#   if [[ -f ${d}.*(.) ]]; then
#     echo ${d}.*(.)
#   fi
# done
#}

##function timestamp() {
##  test ! -z ${1:e} && ext=.${1:e} || ext=${1:e} # test if there's an extension
##  mv $1 ${1:r}-$(now s)$ext # bla.txt -> bla-120728145949.txt
##} # FIXME timestamp file

#function ftime () {
# # A little bit too complicated, I guess.
# f=$1; shift # filename

# if [[ $1 == "Y" ]]; then
#   shift
#   y="%Y"
# else
#   y="%y"
# fi

# p=$1; shift # precision [h|m|s]
# s=$1; shift # stat element [a|c|m]
# d=${+1:-$1} # delimiter
# t=${+2:-$1} # delimiter time/date
# case $p in
#   h) zstat -F "$y$d%m$d%d$t%H"         +${s}time $f ;;
#   m) zstat -F "$y$d%m$d%d$t%H$d%M"     +${s}time $f ;;
#   s) zstat -F "$y$d%m$d%d$t%H$d%M$d%S" +${s}time $f ;;
#   d) zstat -F "$y$d%m$d%d"             +${s}time $f ;;
# esac
#} # $0 <file> <h|m|s> [Y] <a|c|m> {del|del}

#function md5hash () {
# md5sum $1 | cut -c1-$2
#} # $0 <FILE> <HASH LENGTH>

#function ctime-md5 () {
# for i in $@; do
#   mv -i $i $(ftime $i d c "" _)_$(md5hash $i 4).${i:e}
# done
#} #  $0 <FILES> # RENAMES

#function ic () {
# ext=$@[-1]
# for i in $@[1,-2]; do
#   convert $i ${i:t:r}.$ext
# done
#} # CONVERT

# CTRL-T - Paste the selected file path into the command line

# CTRL-R - Paste the selected command from history into the command line
#fzf-history-widget() {
#  LBUFFER+=$(history | fzf +s | sed "s/ *[0-9]* *//")
#  zle redisplay
#}
#zle     -N   fzf-history-widget
#bindkey '^R' fzf-history-widget

# a=33 b=( 3 5 9 ); eval print '$(('$a/${^b}.'))'

# make scratch dir and go there

# go to todays scratch dirs, or the latest one

# TODO oO completion

#hash -d oO=~/.local/tmp/$(now Y d '' / /)

#for i in ~/.local/tmp/$(now Y d '' / /)/*/*(/); do
#   hash -d ${i:t}=$i
#done


# NOTE: Is there a way to warn before overriding existing commands?

#s () {
# r=$1; shift
# c=$1; shift
#
# case $r in
#   b)
#     case $c in
#       s) brew search $@ ;;
#       i) brew install $@ ;;
#     esac
#     ;;
#   g)
#     case $c in
#       s) gem search -r $@ ;;
#       i) gem install -r $@ ;;
#     esac
#     ;;
# esac
#}

# perl -pe 's/keyword/\e[1;31;43m$&\e[0m/g'

# LOCATE_PATH=~/.local/var/db/locate.database
# alias locate=locate...

# TODO check for existing hashes
#find ~tmp -type f -name '.important' | while read -r r; do hash -d ${${r:h}:t}=$r:h; done
#find ~src -type f -name '.important' | while read -r r; do hash -d ${${r:h}:t}=$r:h; done

# locate
# mdfind -onlyin $HOME -name '.important'

# hash -d NodeInspectionFrontEnd=~/.local/src/LiveGovWP1-dev/server/NodeInspectionFrontEnd

# function update() {
#   # TODO nicer output
#   brew update
#   brew upgrade
#   gem update
#   npm update -g
#   softwareupdate -v -i -a
#   #pip-review -v -a
#   #python -c 'import pip, subprocess; [subprocess.call("pip install -U " + d.project_name, shell=1) for d in pip.get_installed_distributions()]'
#   #for i in ~/local/github/**/.git; do cd ${i:r}; pwd; git pull; echo; cd -; done
# }

# echo "random took $(( $($LOCAL/bin/date-epoch-ms.py) - $RANDOM_SH_STARTTIME )) seconds"
