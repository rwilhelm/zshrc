# autoload -U run-help
# autoload run-help-git
# autoload run-help-svn
# autoload run-help-svk
# export HELPDIR=$ZDOTDIR/zsh_help

# unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

DIRSTACKSIZE=12
alias dh="dirs -v"

alias z="$EDITOR $ZDOTDIR"

#alias vim="nvim"

function rr () {
  case $1 in
    "-a")
      source $ZDOTDIR/.zshenv
      source $ZDOTDIR/.zshrc
    ;;
    "-f")
      for i in $ZDOTDIR/functions/*(.); do
        [[ $2 == '-v' ]] && ts_x=$($LOCAL/bin/date-epoch-ms.py)
        source $i || echo "sourcing $i failed"
        [[ $2 == '-v' ]] && echo "$(( $($LOCAL/bin/date-epoch-ms.py) - $ts_x ))" $i
      done
    ;;
  esac
}

function zsh-overwritten-commands () {
  alias | awk -F= '{print $1}' | while read -r l; do [ $(whence -p $l) ] && alias -L $l; done
  functions | awk '/^\w/{print $1}' | while read -r l; do whence -p $l; done
}

function zsh-overwritten-by-homebrew () {
  alias | awk -F= '{print $1}' | while read -r l; do which -p $l; done | grep '/usr/local/bin'
}

# TODO
# find native osx commands overwritten by homebrew/ruby/python etc or my aliases/functions

# TODO
# harden zsh configs
# there should be no aliases/commands including rm and other evil stuff (see evil.sh on github)
