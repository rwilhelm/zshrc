
#@SIMPLE_ALIASES
alias cask="brew cask"
alias bs='brew search'
alias bi='brew install'

alias cp='cp -pvi'
alias df='df -H'
alias file='file -pbI'
alias grep='egrep --colour'
alias mkdir='mkdir -p'
alias mv='mv -iv'
alias rmdir='rmdir -p'
alias tree='tree -C'
alias tar='time tar'

# LS
alias ls="$([[ $(uname -s) == 'Linux' ]] && echo 'ls --color' || echo 'ls -Gh')"
alias l="ls -1"
alias ll="ls -l"
alias la="ls -a"
alias lla='ll -a'
alias lsd="ls -d" # :D
alias lld="ll -d"

alias psu="ps -fHU $USER"
alias calc="bc -l <<<"

# INSTALLED VIA HOMEBREW
alias unp='unp -U'
alias ag='ag --color-line-number="0;34" --color-match="0;31" --color-path="0;33"'

alias bfg='java -jar ~bin/bfg-1.12.12.jar'

alias ag='ag --color-line-number="0;34" --color-match="0;31" --color-path="0;33"'

alias pwdp="pwd -P"

alias rr="source $ZDOTDIR/.zshenv && source $ZSHRC"

alias z="subl -n $ZDOTDIR"

rmdsstore () { find ${1:=.} -name .DS_Store -exec rm -v {} \; }

alias smci="make clean && make && sudo make install"

DWM_SRC=$LOCAL/var/proj/dwm
alias dwmconfig="cd $DWM_SRC && vim config.h && make && sudo make install && cd -"

alias u+x='chmod u+x'

alias -g ND="*(/om[1])" # newest dir
alias -g NF="*(.om[1])" # newest file

alias -g @G="|grep -i"
alias -g DOWNCASE="|tr 'A-Z' 'a-z'"
alias -g UPCASE="|tr 'a-z' 'A-Z'"

alias -g @N="${PWD:t}"

alias -g @D="**/*(/)" # all dirs recursive

# alias -g @CHROME='| sed "s/\"//g" | while read -r line; do open -a /Applications/Google\ Chrome\ Canary.app $line; done'
alias -g @CHROME='| sed "s/\"//g" | while read -r line; do open -a /Applications/Google\ Chrome.app $line; done'

alias -g NUL="> /dev/null 2>&1"

alias zshtips="$BROWSER http://successtheory.com/tips/zshtips.html"
alias zshwiki="$BROWSER http://zshwiki.org/"

alias python="python3"

#alias rm='trash'
