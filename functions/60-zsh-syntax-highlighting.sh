# https://github.com/zsh-users/zsh-syntax-highlighting/issues?labels=Bug&page=1&state=open
# 34 issues, 20 bugs... omg (and it breaks zsh yank-pop)
return

if [[ -f ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_HIGHLIGHTERS+=(pattern)
  ZSH_HIGHLIGHT_STYLES[builtin]='none'
  ZSH_HIGHLIGHT_STYLES[command]='none'
  ZSH_HIGHLIGHT_STYLES[alias]='none'
  ZSH_HIGHLIGHT_STYLES[function]='none'
  ZSH_HIGHLIGHT_STYLES[unknown-token]='none'
  ZSH_HIGHLIGHT_STYLES[path]='none'
  ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red') #FIXME
  ZSH_HIGHLIGHT_PATTERNS+=('rm *' 'fg=red,bold')
fi
