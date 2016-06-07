#
# BIDOS STUFF
# PART 4
#



fake () {
  curl -s localhost:3000/items/fake | curl -s -XPOST -H "Content-Type: application/json" -d @- localhost:3000/v1/crud/$1
  # curl -s localhost:3010/v1/fake/$1 | curl -s -XPOST -H "Content-Type: application/json" -d @- localhost:3010/v1/crud/$1
}

get-auth-token () {
  curl -XPOST -H "Content-Type: application/json" -d '{ "username": "dyb", "password": "123" }' localhost:3010/auth/login
}

auth () {
  curl -s -XPOST -H "Authorization: Bearer $(get-auth-token)" l:3010/v1/resources/vanilla
}

bidos-api () {
  cd ~bidos
  NOAUTH=true NODE_ENV=localdev iojs app/api
}

bidos-www () {
  cd ~bidos
  NODE_ENV=localdev gulp
}

rage () {
	/Volumes/Mars/usr/games/RAGE.app/Contents/MacOS/RAGE +cvaradd g_fov 12 +com_skipIntroVideo 1 +image_anisotropy 16 +image_use +com_allowConsole 1 $@
}

oa () {
	/Volumes/Mars/var/storage/games/_misc2/OpenArena/OpenArena.app/Contents/MacOS/openarena.ub $@
}

oadm() {
	skill=${1:=4.0}
	oa +g_gametype 0 +map oa_dm1 +addbot jenna $skill +addbot ayumi $skill
}

# http://www.joz3d.net/html/q3console.html
