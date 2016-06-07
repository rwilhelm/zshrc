#
# random 6
#

# re-source zsh config and execute last command
function rrx() {
 # TODO
}

# alias dusch="du -sch"
alias wcl="wc -l"

# opened files
of () {
  lsof -Fn -c $1 | sort -u
}

alias vv='grep -v'
alias ff='grep -i'

# alias rm='rm -i' # annoyment(?) vs. safety

dsg () { du -sch $@ | sort -g }

history-stuff () {
  cat << EOF
  \$HISTFILE = $HISTFILE
  \$HISTORY_IGNORE = $HISTORY_IGNORE
  \$HISTSIZE = $HISTSIZE
  \$LC_ALL = $LC_ALL
  \$NODE_REPL_HISTORY_FILE = $NODE_REPL_HISTORY_FILE
EOF
}

# \$hist = $hist
# \$histchars = $histchars
# \$history = $history
# \$historywords = $historywords

find-code () {
  grep $1 -rC2 ~/local/dev/proj | less -F
}

token () {
  curl -s -XPOST -H "Content-Type: application/json" -d '{ "username": "asdf", "password": "123" }' localhost:3000/auth/token 
}

xc () {
  curl -s -H "Authorization: Bearer $(token)" localhost:3000/$1 $@[2,-1]
}

alias -g wrl='while read -r l'
alias -g fri='for i in *'

function const () {
  egrep -ho '[A-Z]+_[A-Z]\w+' -r $1
}

function const-leak () {
  const . | while read -r l; do
    arg=${1:=..}
    a=(${(s:/:)${PWD}})
    b=(${(s:/:)${arg}})
    egrep -lr $l $arg | grep -v build\|public\|node_modules\|$arg/${(j:/:)a[-$#b,-1]}
  done | sort -u
}


mount-efi () { diskutil mount $(diskutil list | grep -B1 'Apple_HFS El Capitan' | head -1 | awk '{print $NF}') }




# doesnt work
# function vpn-connect {
# /usr/bin/env osascript <<-EOF
# tell application "System Events"
#         tell current location of network preferences
#                 set VPN to service "Hide.me" -- your VPN name here
#                 if exists VPN then connect VPN
#                 repeat while (current configuration of VPN is not connected)
#                     delay 1
#                 end repeat
#         end tell
# end tell
# EOF
# }

# function vpn-disconnect {
# /usr/bin/env osascript <<-EOF
# tell application "System Events"
#         tell current location of network preferences
#                 set VPN to service "Hide.me" -- your VPN name here
#                 if exists VPN then disconnect VPN
#         end tell
# end tell
# return
# EOF
# }

alias di='diskutil'

## Most frequent history words (zsh-users)

function hist-words () {
  typeset -A uniq
  for k in ${historywords[@]}; do
      uniq[$k]=$(( ${uniq[$k]:-0} + 1 ))
  done

  vk=()
  for k v in ${(kv)uniq}; do
      vk+="$v=$k"
  done
  print -rl -- ${${${(On)vk}#<->=}[1,10]}
}
