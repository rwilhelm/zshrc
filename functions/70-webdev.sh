#!/usr/sbin/zsh

project-files-to-template () {
  tar czf $LOCAL/templates/js-proj-dotfiles-$(now).tar.gz .*(.) *(.)
}

extract-latest-template-dotfiles () {
  tar xzf $LOCAL/templates/js-proj-dotfiles-*(.om[1])
}

setup-new-project () {
  extract-latest-template-dotfiles
  git init
  e
}

# #!/usr/sbin/zsh

# project-files-to-template () {
#   tar czf $LOCAL/templates/js-proj-dotfiles-$(now).tar.gz .*(.) *(.)
# }

# extract-latest-template-dotfiles () {
#   tar xzf $LOCAL/templates/js-proj-dotfiles-*(.om[1])
# }

# setup-new-project () {
#   extract-latest-template-dotfiles
#   git init
#   e
# }

# skel () {
# 	# copy configuration/template files to current dir

# 	target=$1

# 	cp $LOCAL/skel

# }

# +git () {
# 	git init
# 	git add .
# 	skel
# 	git commit -a -m 'initial commit'
# }


# npm-bootstrap () {

# 	pkgs=(
# 		@cycle/core
# 		@cycle/dom
# 		co
# 		koa@next
# 		react-dom
# 		react-router
# 		react-transform-hmr
# 		rxjs
# 	  react
#     react-dom
#     react-router
# 	)

# 	devpkgs=(
# 		babel
# 		babel-core
# 		babel-eslint
# 		babel-loader
# 		babel-plugin-transform-react-jsx
# 		babel-polyfill
# 		babel-preset-{es2015-node5,react,stage-0}
# 		babel-runtime
# 		webpack
# 		webpack-dev-server
#   )

# 	npm init
# 	npm install $pkgs --save
# 	npm install $devpkgs --save-dev
# 	test -f package.json && git add package.json

# 	mkdir client/src/{model,view,intent}
# 	touch client/{index,api,config,render,routes}.js

# 	mkdir server/{middleware,routes}
# 	touch server/{index,api,config}.js
# }
