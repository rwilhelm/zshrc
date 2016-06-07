#!/usr/bin/env zsh
# Do not use! It will f'up your things.
# 1999-2016 (c) rene.wilhelm@gmail.com
# Last review: Tue Jun  7 01:44:31 CEST 2016

# profile function dumps like
# DEBUG=true; { repeat $(($LINES-2)) time zsh -ic exit } | grep zsh
# zsh -ic exit  0.13s user 0.10s system 124% cpu 0.182 total

# '.zshrc' is sourced in interactive shells. It should contain commands to set
# up aliases, functions, options, key bindings, etc.

# echo ". zshrc"

bindkey -e
unhash -m '*' # forget everything

if [[ $DEBUG ]]; then
  for f in $ZDOTDIR/functions/*(.); do
    local t=$EPOCHREALTIME
    source $f || echo "sourcing $f failed"
    printf "%.22f %s\n" $(( $EPOCHREALTIME - $t )) $f:t
  done | sort -g | tail -$((LINES-3)) | lolcat
  unset f
else
  for f in $ZDOTDIR/functions/*(.); do
    source $f || echo "sourcing $f failed"
  done
fi

echo $(( $EPOCHREALTIME - $ZSHSTARTTIME )) | lolcat -p .5 # -p 3 -a -s 10 -d 100
