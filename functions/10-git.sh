function gg () {
  a=(${(s|/|)1})
  d=~/local/dev/src/$a[2]/$a[3]
  test -d $d && cd $d && return
  mkdir $d
  cd $d
  git clone $1
  # g=(${(s/./)a})[1]
  cd *(/om[1])
  return
}

sf-git () {
  for dir in $@; do
    test ! -f $dir/.git/config && continue
    sortdir=$HOME/local/dev/src/$(awk -F/ '/url/{ if (length($3) > 0) { printf ("%s/%s/%s\n"), $3, $4, $5 } }' $dir/.git/config)
    # if [[ $sortdir ]]; then
      echo $sortdir
      # mkdir $sortdir && mv $dir $sortdir
    # fi
  done
}
