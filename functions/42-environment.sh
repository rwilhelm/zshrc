
#@ENVIRONMENT_INFO
function sqlite-build-variables () {
  echo LDFLAGS:  -L/usr/local/opt/sqlite/lib
  echo CPPFLAGS: -I/usr/local/opt/sqlite/include
}

#@ENVIRONMENT_INFO
function env_info () {
	which -ps node ruby npm brew perl python | sort | lolcat -F 0.5
	# commands=(node iojs ruby npm brew perl python)
	# for cmd in $commands; do
	# 	echo -e "\e[1;32m[ \e[0;32m${(U)cmd} \e[1;32m] \e[0;00m$@"
	# 	echo $
	# done
}

export KANT="Man wird hier bald gewahr, daß in dieser Tafel die Freiheit als eine Art von Causalität, die aber empirischen Bestimmungsgründen nicht unterworfen ist, in Ansehung der durch sie möglichen Handlungen als Erscheinungen in der Sinnenwelt betrachtet werde, folglich sich auf die Kategorien ihrer Naturmöglichkeit beziehe, indessen daß doch jede Kategorie so allgemein genommen wird, daß der Bestimmungsgrund jener Causalität auch außer der Sinnenwelt in der Freiheit als Eigenschaft eines intelligibelen Wesens angenommen werden kann, bis die Kategorien der Modalität den Übergang von praktischen Principien überhaupt zu denen der Sittlichkeit, aber nur problematisch einleiten, welche nachher durchs moralische Gesetz allererst dogmatisch dargestellt werden können."
