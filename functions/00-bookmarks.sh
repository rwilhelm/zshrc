# add/remove (toggles) the current pwd to $ZDOTDIR/bookmarks. on shell init
# this file is read and named dirs which are accessible via a tilde to the
# name (e.g. ~bla) are added

#@SHELL_FEATURES
function ii () {
	k=${${(L)PWD:t}/[ \.]/}

  if ! $(hash -dv $k 2>/dev/null | grep -q "^$k=$PWD$"); then
    hash -dv $k=$PWD >> $ZDOTDIR/bookmarks
  else
    unhash -d $k
    sed -i "" "/$k/d" ~/.zsh/bookmarks
  fi
}

# hash -d addtoitunes=~mars/var/itunes_media/Automatically\ Add\ to\ iTunes
