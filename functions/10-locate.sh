if [[ $(uname -s) == "Darwin" ]]; then
	[ ! $(whence -p glocate) ] && (echo "gnu locate not found. install findutils."; return 0)
elif [[ $(uname -s) == "Linux" ]]; then
	[ ! $(whence -p locate) ] && (echo "gnu locate not found. install mlocate."; return 0)
fi

alias locate=glocate
alias updatedb=gupdatedb

LOCATE_DIR=$LOCAL/var/db/locate

#export LOCATE_PATH=$(test -d $LOCATE_DIR && (print -l $LOCATE_DIR/* | paste -sd':' -)) FIXME

alias loc='glocate -Air'

function locate-init () {
	# usage : $0 DATABASE_NAME [PATHS]
  # create new locate database from external device
  echo LC_ALL='C' gupdatedb --localpaths=${(q)$@[2,-1]} --output=$LOCATE_DIR/$1.locate_db
}

function locate-update () {
	LC_ALL='C' gupdatedb --localpaths=/Volumes/{Earth,Moon}/var/storage --output=$LOCATE_DIR/storage.locate_db
}

function locate-find () {
	glocate -Air --database=$LOCATE_DIR/storage.locate_db
}

function loc-archive () {
	# update archive database
	# init archive
	# add to archive
	# find in archive
	# remove from archive
	# create search report/package
	# rsync result to ... [--flatten]
}
