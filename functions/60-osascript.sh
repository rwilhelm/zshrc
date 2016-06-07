function osx-volume() {
  sudo osascript -e "set Volume $1"
}

function itunes-volume() {
  # osascript -e 'tell application "iTunes" to sound volume as integer'
  osascript -e "tell application \"iTunes\" to set sound volume to $1"
}
