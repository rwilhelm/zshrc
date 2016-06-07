#!/usr/bin/env zsh

export PORT=3000

alias g="git"
alias gitjk="history 10 | tail -r | gitjk_cmd"

alias jsx="jsx --harmony"
jsxwatch() { jsx -x jsx -w --relativize $@ }

pick () { jq ".[].$1" }

xdelete () { curl -s -XDELETE localhost:$PORT/$1 $@[2,-1] }
xpatch  () { curl -s -XPATCH  localhost:$PORT/$1 $@[2,-1] }
xpost   () { curl -s -XPOST   localhost:$PORT/$1 -d "$@[2,-1]" -H "Content-Type: application/json" }
xput    () { curl -s -XPUT    localhost:$PORT/$1 $@[2,-1] }
xget    () { curl -s -XGET    localhost:$PORT/$1 $@[2,-1] }

# x () {
#   PORT=3000
#   METHOD=${1:u}; shift;
#   URL=${1}; shift;
#   JSON=$@

#   if [[ ${METHOD} == "POST" ]]; then
#     IF_POST="-H \"Content-Type: application/json\" -d \"${JSON}\""
#   fi
#   echo "curl -X${METHOD} localhost:${PORT}/${URL} ${IF_POST}"
# }

xgetauth () { curl -s -XGET -H "Authorization: Bearer $(xtoken)" localhost:$PORT/$1 $@[2,-1] }
xpostauth () { curl -s -XPOST -H "Content-Type: application/json" -H "Authorization: Bearer $(xtoken)" localhost:$PORT/$1 $@[2,-1] }
xtoken () { curl -XPOST -H "Content-Type: application/json" -d '{ "username": "asdf", "password": "123" }' localhost:$PORT/auth/token }

# GIT ===================================================================================

# better use `hub create`
function github-create-remote () {
	repository=${1//.git}
	git remote add origin git@github.com:$repository.git && git push -u origin master
}

# git time machine <3
function gtm () {
	git show HEAD~$2\:$1 | pygmentize | less -R
}

# clone repository to ~local/src
function gg2 () {
  pushd $LOCAL/src && git clone $1 && cd $1:r:t && subl -n .
}

# get the name of the currently checked out branch
function git-current-branch () {
  git branch | sed 's/^\* //;$!d'
}

# get the name of the latest release
function git-latest-release () {
  git branch -ar | sort -t. -k2,2n -k3,3n | sed 's/.*origin\///;$!d'
}

function git-changelog () {
  git --no-pager log HEAD..origin/${1:=$(git-current-branch)} --oneline
}

function git-repository-is-fresh () {
  [[ -z $(git-changelog ${1:=$(git-current-branch)}) ]] && return 0 || return 1
}

# http://stackoverflow.com/questions/338436/is-there-a-quick-git-command-to-
# see-an-old-version-of-a-file
function git-show-past () {
	revistion=$1; shift # HEAD~4 HEAD@{2013-02-25}
	path_to_file=$@
	git show $revision:$path_to_file
}



