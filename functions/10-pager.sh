
ccat='pygmentize'
cless() { pygmentize $1 | less -R }

export LESS='-R'
# export LESSOPEN='|lessfilter %s'
