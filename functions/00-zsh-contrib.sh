# see zshcontrib
export VISUAL=vim # FIXME move this

# Enable ctrl-x e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

autoload -U expand-absolute-path
zle -N expand-absolute-path
bindkey '^xf' expand-absolute-path

autoload -U copy-earlier-word
zle -N copy-earlier-word
bindkey '^xc' copy-earlier-word

# set ESC-P
# setopt autolist ESC-P
# setopt nocorrect_

# hosts=()
