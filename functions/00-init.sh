# setup and init stuff

link-dotfiles() {
  # TODO use rsync and/or Makefile
  cd ~
  for i in $LOCAL/{etc/*,var/log/*}; do
    ln -sfv $i .${i:t}
  done
}
