
#@ENVIRONMENT_SET PATH
# export BUNDLE_PATH=$GEM_PATH


#@VIRTUALENV
# if [[ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]]; then
#   source /usr/local/opt/chruby/share/chruby/chruby.sh # {chruby, auto}
#   chruby ruby-2.3.0 # default ruby
#   export PATH=$PATH:$HOME/.gem/ruby/$RUBY_VERSION/bin
# fi


#@PACKAGE_MANAGEMENT
function install-ruby () {
  ruby-install ruby stable -- \
  --with-readline-dir=$(brew --prefix readline) \
  --with-openssl-dir=$(brew --prefix openssl)
}
