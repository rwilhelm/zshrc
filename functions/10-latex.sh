
LATEX_SKEL=$LOCAL/uni/skel

bib () { sed -n "/\@$1{/,/^\}$/p" $LATEX_SKEL/example.bib }


# sudo tlmgr conf texmf TEXMFHOME "~/Library/texmf:~/texmf"
export TEXMFHOME=~/.texmf

function pdflala() {
  n=${PWD:t}
  if [[ $1 == "x" ]]; then x=xelatex; shift; else x=pdflatex; fi # FIXME ternary
  if [[ -f ${1:-$n.tex} ]]; then
    eval $(echo {$x,biber,$x,$x}\ ${1:-$n}\ \&\& true)
    ps -p $(pidof mupdf) | grep -q $n.pdf
    if [[ $? -eq 1 ]]; then
      mupdf ${1:-$n}.pdf &
    else
      for i in $(pidof mupdf); do kill -SIGHUP $i; done
    fi
  else
    echo "Usage: $0 [x] [jobname] (default: $n)"
  fi
} # awesome :)

function maketex() {
  clean 1>/dev/null && echo XELATEX 1
  xelatex $PWD:t @G -q "\(re\)run Biber|^\(biblatex\).*$PWD:t" && echo BIBER && biber $PWD:t 1>|/dev/null && echo XELATEX 2
  xelatex $PWD:t @G -q "Rerun to get cross-references right.|Please rerun LaTeX." && echo XELATEX 3
  xelatex $PWD:t @G -q "rerun "
  echo FINISH
}

function maketex2() {
  clean 1>/dev/null

  if [[ ! -f $PWD:t.aux ]]; then
    echo XELATEX 1
    xelatex $PWD:t @G -q "\(re\)run Biber|^\(biblatex\).*$PWD:t"
    (( $? )) && BIBER=true
  fi

  if (( $BIBER )); then
    echo BIBER
    biber $PWD:t 1>|/dev/null
    echo XELATEX 2
    xelatex $PWD:t @G -q "Rerun to get cross-references right.|Please rerun LaTeX."
    (( ! $? )) && LATEX=true
  fi

  if (( $LATEX )); then
    echo XELATEX 3
    xelatex $PWD:t @G -q "rerun "
    echo FINISH
  fi
}

function maketex3() {
  n=${PWD:t}

  if [[ ! -f $n.aux ]]; then
    LATEX=true
    BIBER=true
  fi

  if $BIBER; then
    echo RUNNING BIBER
    biber $n
    unset BIBER
    return
  fi

  if $LATEX; then
    echo RUNNING XELATEX
    xelatex $n | tee -a $n.tee
    unset LATEX
    return
  fi

  grep "\(re\)run Biber|^\(biblatex\).*$PWD:t" $n.tee && BIBER=true
  grep "Rerun to get cross-references right.|Please rerun LaTeX." $n.tee && LATEX=true

  while $BIBER -or $LATEX; do
    maketex
  done
}


function clean() {
  n=${PWD:t}
  if [[ $1 == "-a" ]]; then
    shift
    {} always { rm -v $n.pdf } 2>/dev/null
  fi
  for e in aux bbl bcf blg log out run.xml toc fdb_latexmk fls brf url glo ist idx; do
    {} always { rm -v *.$e } 2>/dev/null
  done
}
