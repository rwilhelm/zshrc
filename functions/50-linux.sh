[[ ! -f /etc/arch-release ]] && return


if [[ "$(uname -s)" == "Linux" ]]; then
  # we're on linux
  alias l-d="ls -lFad"
  alias l="ls -laF"
  alias ll="ls -lFa | TERM=vt100 less"
fi

alias aoe="setxkbmap -layout us -variant mac"
alias asd="setxkbmap -layout us -variant dvorak"

alias yz="setxkbmap -layout us -variant mac"
alias zy="setxkbmap -layout de"

compdef _pacman {ss,sy,ql}=pacman

#alias pkginstall="makepkg -s && sudo pacman -U *xz"
#alias ql="pacman -Ql"
#alias ss="pacman -Ss"
#alias sy="sudo pacman -Sy"
#alias syu="sudo pacman -Syu"

#alias rr='source $ZSHRC && rehash && (test -z $XAUTHORITY || xrdb -merge ~/.Xresources)'
#alias z="vim $ZSHRC" # ~/.vimrc ~/.Xdefaults ~/.dir_colours && rr" # FIXME write completion

#function aur() {
#	for i in $@; do
#		cower -d $i -t ~/local/tmp
#		cd ~/local/tmp/$i
#		makepkg -s
#		sudo pacman -U *xz
#		cd -
#	done
#}

##
## https://wiki.archlinux.org/index.php/Pacman_Tips
##
##pacman-backup() { pacman -Qqe | grep -v "$(pacman -Qqm)" > pacman.lst }
##pacman-restore() { cat pacman.lst | xargs pacman -S --needed --noconfirm }
##pacman-ls-foreign() { pacman -Qqm }
##pacman-ls-explicitely-installed() { pacman -Qqe }
##pacman-ls-from-aur() { for x in `pacman -Qm`; do yaourt -Ss "$x" | grep 'aur/'; done }
##pacman-needed() { pacman -S --needed $(cat pacman.lst) }
##pacman-local() { yaourt -S $(cat pacman-local.lst) }
##pacman-ls-no-depends() { expac "%n %N" -Q $(expac "%n %G" | grep -v ' base') | awk '$2 == "" {print $1}' }
##pacman-ls-etc-modified() { pacman -Qii | awk '/^MODIFIED/ {print $2}' }
###pacman-ls-size() { pacman -Si "$@" 2>/dev/null" | awk -F ": " -v filter="Size" -v pkg="Name" \ '$0 ~ pkg {pkgname=$2} $0 ~ filter {gsub(/\..*/,"") ; printf("%6s KiB %s\n", $2, pkgname)}' | sort -u -k3 \ | tee >(awk '{TOTAL=$1+TOTAL} END {printf("Total : %d KiB\n",TOTAL)}') }
##pacman-ls-officially-installed() { pacman -Qq |\grep -Fv -f <(pacman -Qqm) }

