# #
# Zsh node.js functions
# Last update: Thursday 13 March 2014 19:54
# Copyright (c) rene.wilhelm@gmail.com
#

[ ! $(whence -p npm) ] && (echo "npm not found."; return)

# . <(npm completion)

export NODE_REPL_HISTORY_FILE=~/.node-repl-history


ni () { npm install $@ }
nis () { ni --save $@ }
nisd () { ni --save-dev $@ }

alias -g __ESLINT="eslint{,-plugin-{babel,react}}"
alias -g __BABEL

ba () {
  opts=()
  test -d ./node_modules/babel-preset-stage-0 && opts=($opts -b stage-0)
  test -d ./node_modules/babel-preset-es2015 && opts=($opts -b es2015)
  test -d ./node_modules/babel-preset-react && opts=($opts -b react)
  echo babel-node $opts
  babel-node $opts
}

repl () { nr }

# export NODE_PATH=$LOCAL/opt/node/lib/node_modules
# alias npm="npm --nodedir=$LOCAL/src/node"
# alias node="node --harmony"
# alias nodemon="DEBUG=express:\* nodemon"

function npmoffline () {
  npm --cache-min 9999999
}

function npm-gyp-fix() {
  # https://github.com/TooTallNate/node-gyp/pull/564
  npm --node-gyp=/usr/local/bin/pangyp/bin/node-gyp.js
}

function fswatch_ () {
	w=$1 # watched
	c=$@[2,-1] # command to exec
  fswatch -0 -E $w | xargs -0 -n1 -I{} rsync -chavzP --stats $c
}

function update-node-completions () {
  completion_dir=$ZDOTDIR/functions/Completion

  npm completion > $completion_dir/_npm

  [ $(whence -p karma) ] && karma completion > $completion_dir/_karma
  [ $(whence -p grunt) ] && grunt --completion=zsh > $completion_dir/_grunt
}

function mkindex.js () {
  ls -1 *.js | while read -r l; do
    echo "${l//.js}: require('${l//.js}');";
  done | awk '
    BEGIN { print "use \x27strict\x27;\nmodule.exports = {"; };
    { printf "  %s\n", $0 };
    END { print "}\n" }'
  }


function mkindex2.js () {
  echo "'use strict';"
  ls -1 *.js | while read -r l; do
    echo "exports.${l//.js} = require('${l//.js}');";
  done
  echo
}

# function update-node () {
#   pushd $LOCAL/src/node
#   git fetch -q origin
#   current_branch=$(git-current-branch)
#   latest_release=$(git-latest-release)
#   if ! $(git-repository-is-fresh); then
#     git merge
#     if [[ $current_branch != $latest_release ]]; then
#       echo "New branch! $current_branch -> \e[0;31m$latest_release\e[0;0m"
#     else
#       git checkout $latest_release
#     fi
#     ./configure --prefix=$LOCAL/opt/node && make && make install
#   else
#     echo "Your current node branch \e[0;32m$latest_release\e[0;0m is up to date. :)"
#   fi
#   popd
# }

# function update-node () {
#   pushd $LOCAL/src/node
#   git fetch origin
#   current_release=$(git branch | sed 's/^\* //;$!d')
#   latest_release=$(git branch -ar | sort -t. -k2,2n -k3,3n | sed 's/.*origin\///;$!d')
#   if [[ -n $(git log HEAD..origin/$latest_release --oneline) ]]; then
#     if [[ $current_release != $latest_release ]]; then
#       echo "New branch! $current_release -> \e[0;31m$latest_release\e[0;0m"
#     fi
#     git merge
#     git checkout $latest_release
#     ./configure --prefix=$LOCAL/opt/node
#     make
#     make install
#   else
#     echo "Your current node branch $latest_release is up to date. :)"
#   fi
#   popd
#   npm update -g
# }

# function fnm () {
#   cmd=$(whence -p nodemon)
#   PORT=3000
#   while lsof -i :$PORT NUL; do
#     PORT=$((PORT+1))
#   done && PORT=$PORT DEBUG=express:\* forever start -c $cmd --exitcrash (app|server).js
# }

# function nife () {
#   unset HISTFILE
#   a=${1:=NodeInspectionFrontEnd}
#   # TODO add option to do all of this in a new terminal window
#   # TODO use project file
#   tab "cd ~$a && clear && PORT=3000 DEBUG=express:* nodemon app.js"
#   tab "tail -fn0 /usr/local/var/postgres/server.log"
#   tab "cd ~$a && clear"
#   subl -s ~$a # ~proj/subl/$a.sublime-project
# }

# function tmux-node-run {
#   [ $(which -p tmux) ] || echo "tmux not found"; return

#   BASE="$HOME/local/srv"

#   tmux start-server
#   tmux new-session -d -s node_run -n old:3000
#   tmux new-window -t node_run:2 -n har:3001
#   tmux new-window -t node_run:3 -n ng:3002

#   tmux send-keys -t node_run:1 "cd $BASE/NodeInspectionFrontEnd && PORT=3000 DEBUG=express:\* nodemon app.js" C-m
#   tmux send-keys -t node_run:2 "cd $BASE/har && PORT=3001 DEBUG=express:\* nodemon har-server.js" C-m
#   tmux send-keys -t node_run:3 "cd $BASE/NodeAngularFrontEnd && PORT=3002 DEBUG=express:\* nodemon server.js" C-m

#   tmux select-window -t node_run:1
#   tmux attach-session -t node_run
# }
