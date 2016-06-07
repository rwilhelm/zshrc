#
# Zsh OS X functions
# Last update: Thursday 13 March 2014 20:14
# Copyright (c) rene.wilhelm@gmail.com
#

[[ $(uname -s) == "Darwin" ]] || return 0

# restart a daemon
# args: daemon name FIXME autocompletion
function launchdRestart () {
  launchctl unload ~/Library/LaunchAgents/$1
  launchctl load ~/Library/LaunchAgents/$1
}

function ldr () {
  ls -1 ~/Library/LaunchAgents
  read -r daemon
  launchdRestart $daemon
}
