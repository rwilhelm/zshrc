function iterm-split-vertically() {
  osascript -e 'tell application "System Events" to key code 2 using command down'
}

function iterm-split-horizontally() {
  osascript -e 'tell application "System Events" to key code 2 using {command down, shift down}'
}

function iterm-livegov() {
  d=~nodeangularfrontend
  cd $d
  subl -bn $d
  exec gulp
  iterm-split-horizontally
  tail -f /usr/local/var/postgres/server.log
}

