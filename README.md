~̵͒̓ͦ̃/.zsh̀͝r̷̢c̙̲
ͪ̿̎
========

mute motd
---------
```shell
touch ~/.hushlogin
cmp -s $HOME/.hushlogin /etc/motd
if [ $? != 0 ]; then
  tee $HOME/.hushlogin < /etc/motd
  echo -n "Press Enter to continue: " && read ans
fi
```

see that thing about login shells
---------------------------------
```shell
sudo opensnoop -f /private/var/log/asl/ | grep login
sudo opensnoop | grep login # then open new login shell
```

remove other users and user-like things from tilde completion
-------------------------------------------------------------
```shell
zstyle ':completion::complete:-tilde-::' tag-order '! users'
```

kind of bookmarks
-----------------
```shell
function ii () {
  if ! $(hash -dv ${(L)PWD:t} NUL | grep -q "^${(L)PWD:t}=$PWD$"); then
    hash -dv ${(L)PWD:t}=$PWD > $ZDOTDIR/.hashed_dirs
  else
    unhash -d ${(L)PWD:t}
    sed -i "" "/${(L)PWD:t}/d" $ZDOTDIR/.hashed_dirs
  fi
}
```

put into .zlogin
----------------
```shell
< $ZDOTDIR/bookmarks | while read -r i; do hash -d $i; done
```
