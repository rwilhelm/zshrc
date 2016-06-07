# '.zshenv' is sourced on all invocations of the shell, unless the -f option is
# set. It should contain commands to set the command search path, plus other
# important environment variables. '.zshenv' should not contain commands that
# produce output or assume the shell is attached to a tty.

# echo ". zshenv"

# export ZSHSTARTTIME=$(/usr/local/bin/python3 -c 'import datetime;
# print((datetime.datetime.now() - datetime.datetime(1970, 1, 1)).total_seconds())')


zmodload zsh/datetime
export ZSHSTARTTIME=$EPOCHREALTIME

export LOCAL=~/local
export ZSHRC=$ZDOTDIR/.zshrc

setopt AUTO_CD AUTO_PUSHD PUSHD_SILENT PUSHD_MINUS PUSHD_TO_HOME
setopt COMPLETE_ALIASES COMPLETE_IN_WORD NO_LIST_TYPES
setopt EXTENDED_GLOB NUMERIC_GLOB_SORT BRACE_CCL CSH_NULL_GLOB
setopt NO_HUP
setopt PROMPT_SUBST

source $ZDOTDIR/.zshenv.history
source $ZDOTDIR/.zshenv.path

# ZSH ENVIRONMENT SETTINGS
WORDCHARS='*_[]~;!#$%^(){}<>' # ./?&-=

# TODO how do i know if i need to export these or not?
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH # screws with homebrew
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8" # omg, don't use 'C'
export XZ_DEFAULTS=--memlimit=40%
export PWS_SECONDS=30
export GRATIO=1.6180339887498948482

# http://linux-sxs.org/housekeeping/lscolors.html
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=1;;44:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:mi=31"

autoload -U compinit && compinit -i
autoload -U promptinit && promptinit && prompt rene
autoload -U zargs
autoload -U zmv

zmodload -F zsh/stat b:zstat

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' cache-path $ZDOTDIR/cache
zstyle ':completion:*' use-cache on

zstyle ':completion::complete:-tilde-::' tag-order '! users'
#zstyle ':completion:*:complete:-tilde-:*' tag-order '! users'
#zstyle ':completion::complete:-tilde-::' tag-order _users() { };

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# order matters
source $ZDOTDIR/functions/Widgets/zaw/zaw.zsh
# source $ZDOTDIR/functions/Widgets/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/functions/Widgets/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh # 10

BOOKMARKS=$ZDOTDIR/bookmarks
while read l; do hash -d $l; done < $BOOKMARKS
