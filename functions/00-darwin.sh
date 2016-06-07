if [[ ! "$(uname -s)" == "Darwin" ]]; then
  exit
fi

# do OS X specific things
# alias eject="diskutil eject"
alias flushdns="dscacheutil -flushcache"
alias killSS='kill -9 $(ps ww |grep ScreenSaverEngine |grep -v grep |awk "{print $1}")'
alias l-d="ls -lFaGd"
alias l-h="ls -laFGh"
alias l-l="ls -laFG"
alias l="ls -laFG"
alias ll="ls -lFa | TERM=vt100 less"

# `wifi on` to turn wifi on, and `wifi off` to turn it off
# alias wifi="networksetup -setairportpower $(networksetup -listallhardwareports | grep -A 2 'Hardware Port: Wi-Fi' | grep 'Device:' | awk '{print $2}')"

# QuickLook stuff
alias ql="qlmanage -p"
# alias quicklook="qlmanage -p"
alias spotlight="mdfind -onlyin `pwd`"
alias top="TERM=vt100 top"

# Manually remove a downloaded app or file from the quarantine
function unquarantine() {
  for attribute in com.apple.metadata:kMDItemDownloadedDate \
    com.apple.metadata:kMDItemWhereFroms \
    com.apple.quarantine; do
    xattr -r -d "$attribute" "$@"
  done
}

function cleanxmlclip {
  pbpaste | tidy -xml -wrap 0 | pbcopy
}

function pledit() { # plist editor.
  if [ $# -ne 1 ]; then
    echo -e "pledit: Edit Apple plist file\nusage: pledit plist_filename"
  else
    sudo plutil -convert xml1 "${1}"; # convert the binary file to xml
    sudo ${EDITOR} "${1}"; # use the default editor
    sudo plutil -convert binary1 "${1}" # convert it back to binary
  fi
}

# Sound.
alias stfu="osascript -e 'set volume output muted true'"
alias mute="osascript -e 'set volume output muted true'"
alias unmute="osascript -e 'set volume output muted false'"

# Airplay sometimes craps out, add helper to kick it
function fix_airplay {
  sudo kill $(ps -ax | grep '/usr/sbin/coreaudiod' | awk '{print $1}')
}

# else
# alias cputop="top -o cpu"
# alias l-d="ls -lad"
# alias l="ls -la"
# alias ll="ls -la | less"
# fi
