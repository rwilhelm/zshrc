#
# Zsh OS X functions
# Last update: Thursday 13 March 2014 20:14
# Copyright (c) rene.wilhelm@gmail.com
#

[[ $(uname -s) == "Darwin" ]] || return 0

function wifi-restart () {
  networksetup -setairportpower en0 off
  networksetup -setairportpower en0 on
}

function lighttable-update () {
  cd $LOCAL/src
  if [[ -d LightTable ]]; then
    cd LightTable
    git pull
  else
    git clone https://github.com/LightTable/LightTable.git
    cd LightTable
  fi
  sh osx_deps.sh
  export LT_HOME=$(pwd)/deploy
  ./deploy/light
}

function chrome-purge-extensions() {
  for i in ~/Library/Application\ Support/Chromium/Default/Extensions/*(/); do
    if [[ ${#$(ls -1 $i)} -gt 1 ]]; then
      trash $i/*^(Om[1,-2])
    fi
  done
}

alias hide="chflags hidden"
alias uhide="chflags nohidden"

alias chrome='/usr/bin/open -a "/Applications/Google Chrome.app"'
alias mplayer='~/Applications/MPlayer\ OSX\ Extended.app/Contents/Resources/Binaries/mpextended.mpBinaries/Contents/MacOS/mplayer'

function osx-repair-permissions () {
  sudo chmod -R 755 kextfile.kext
  sudo chown -R root:wheel kextfile.kext
  sudo rm -R Extensions.kextcache
  sudo rm -R Extensions.mkext
  diskutil repairPermissions /
}

function omnireset () { # reset omnigroup trials
  defaults -currentHost read 'Apple Global Domain' \
    | awk '/omnigroup/{print $1}' \
    | while read -r line; do
      eval defaults -currentHost delete \"Apple Global Domain\" ${line}
    done
}

function rmcaches () {
  for i in /System/Library/Caches/* /Library/Caches/* ~/Library/Caches/*; do
    sudo rm -rf $i
  done
}


# toggle hidden flag on files or directories
function toggle-hidden () {
  for i in $@; do
    ls -lOd $i | grep -oq hidden && chflags nohidden $i || chflags hidden $i
  done
}

# toggle visibility of hidden files
function toggle-hidden-display () {
  if [ $(defaults read com.apple.finder AppleShowAllFiles) = false ]; then
    defaults write com.apple.finder AppleShowAllFiles true
    echo "Hidden files are visible."
  else
    defaults write com.apple.finder AppleShowAllFiles false
    echo "Hidden files are hidden."
  fi
  killall Finder
}

# returns version string of e.g. apps or kexts
function CFBundleShortVersionString () {
  for i in $@; do
    plutil -p $i/Contents/Info.plist | awk -F" => " '/CFBundleShortVersionString/{gsub("\"",""); print $NF}'
  done
}

# append version to app or kext directory
function CFBundleShortVersionString-rename() {
  for i in $@; do
    v=$(CFBundleShortVersionString $i) || echo "$i: no CFBundleShortVersionString found. Skipping."; continue
    mv $i "${i:r} $v.${i:e}";
  done
}

# create versioned zip file for e.g. apps or kexts
function CFBundleShortVersionString-zip() {
  for i in $@; do
    v=$(CFBundleShortVersionString $i) || echo "$i: no CFBundleShortVersionString found. Skipping."; next
    zip -r ${${i:r}/ /}-$(CFBundleShortVersionString $i).zip $i;
  done
}

# find mplayer binaries in /Applications
function mplayer-which () { ls -l /Applications/*[Mm][Pp]layer*/**/mplayer*(x.) }

function pledit() {
  test ! -O $1 && x=sudo
  $x plutil -convert xml1 $1 && subl -wn $1
  $x plutil -lint $1 && $x plutil -convert binary1 $1
}

function font-corrupts () {
  mdfind "com_apple_ats_font_invalid == 1"
}

function ql () {
  qlmanage -p $@ NUL
}

function sc () {
  screencapture -l$(osascript -e 'tell app "iTerm" to id of window 1') $1
  # cloudapp -d $1
  # archive $1
}

function ttys () {
  ls -1 /dev/ttys??? | cut -dy -f2 | while read -r l; do ps -t $l; echo; done
}

# FIXME
# fix non executable app binaries
function osx-fix-app-permissions () {
  for i in /Applications/*(/); do
    a=${${i:t}/.app/};
    e=$i/Contents/MacOS/$a;
    if test -f $e -a -x $e; then
      chmod -v 755 $e;
    fi;
  done
}

function osx-free-space () {
  # remove caches and stuff
  brew cleanup # -s
}

function o () { open ${$1:=.} } # FIXME

function install-osx () {
  app=~/Desktop/Install\ OS\ X\ El\ Capitan.app
  vol=/Volumes/El\ Capitan\ Installer
  sudo $app/Contents/Resources/createinstallmedia --volume $vol --applicationpath $app
}

dsdt-extract () {

}
