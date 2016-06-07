#@STRING_MANIPULATION
function camelize () {
  ruby -e "$_.gsub!(/(^|\s)\S/) {|s| s.delete(' ').upcase }" $@
}
