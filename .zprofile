#echo ". zprofile"

# If the shell is a login shell, commands are read
# from /etc/zprofile and then $ZDOTDIR/.zprofile.

# Not sourced on interactive (-i) shell!

eval $(ssh-agent) 1>/dev/null

function cleanup {
  eval $(ssh-agent -k) &>/dev/null
}

trap cleanup EXIT
