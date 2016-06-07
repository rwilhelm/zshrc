alias -g _PICTURE='*.jpg *.jpeg *.png *.gif *.JPG *.JPEG *.PNG *.GIF *.tiff *.TIFF *.svg *SVG'
alias -g _AUDIO='*.ogg *.mp3 *.flac *.m4a'
alias -g _VIDEO='*.avi *mkv'
alias -g _PACKAGE='*.tar *.zip'

alias -g _IO='| tee >(curl -sF "f:1=<-" ix.io | tee >(pbcopy)) && open $(pbpaste)'

function global-aliases() { alias -g }

# alias | grep '^[a-zA-Z0-9]{1}\b'

alias -g DEAD_LINKS=".*(-@)"
