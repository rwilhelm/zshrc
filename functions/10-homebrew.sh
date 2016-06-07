# [ ! $(whence -p brew) ] && (echo "homebrew not found."; return)

# To use Homebrew's directories rather than ~/.rbenv add to your profile:
#   export RBENV_ROOT=/usr/local/var/rbenv

# To enable shims and autocompletion add to your profile:
#   if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#@PACKAGE_MANAGEMENT
function update-brew () {
  brew update
  [[ -n $(brew outdated ) ]] && brew upgrade
}

#@PACKAGE_MANAGEMENT AUTOMATION
# brew search for something and open all urls in your browser
function brew-info () {
  brew search $1 | while read -r line; do
    brew info $line 2>|/dev/null
  done | grep '^http' | while read -r url; do
    open $url;
  done
}
