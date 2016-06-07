yt-audio () {
	idx=$(youtube-dl -F $1 | grep 'audio only' | sort -k7 | tail -1 | cut -d\  -f1)
	youtube-dl -f $idx $1
}

yt-audio-to-itunes () {
	cd ~addtoitunes
	yt-audio $1
	cd -
}
