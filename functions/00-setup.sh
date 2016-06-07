#
# GROW INTO HOST SYSTEMS AND INSTALL STUFF ETC
#



PYTHON_PACKAGES=(
  pygments
)

RUBY_PACKAGES=(
  selecta
  roman-numerals
  mechanize
  nokogiri
  pry
  scss_lint
  rocco
  lolcat
  rails
  sass
  sinatra
)

HOMEBREW_PACKAGES=(
  vim
)

NODE_PACKAGES=(
)

PERL_PACKAGES=(
)

install-packages () {
 pip install PYTHON_PACKAGES
 gem install RUBY_PACKAGES
 brew install HOMEBREW_PACKAGES
 npm install -g NODE_PACKAGES
 perlbrew install PERL_PACKAGES
}

create-new-history () {
  # create a new history on fresh host system, rename the old one and be able
  # to toggle between the current and historic histories
}
