#local requirements=(mpd mpdscribble mpc ncmpc ncmpcpp mpdfavd mpdfav-import)

# TODO
# check for required dependencies
# automatically install dependencies if not found

function mpc-artist() { cat <<< END | while read -r artist; do mpc search artist $artist | mpc add; done } # FIXME

function ++ () { mpc sendmessage ratings like }
function -- () { mpc sendmessage ratings dislike }
