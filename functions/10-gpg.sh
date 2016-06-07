
gpg-export-my-key() {
	gpg --armor --export $EMAIL
}

# gpg-encrypt-eof() {
# 	# cat << EOF | gpg --encrypt --armor -r $EMAIL | curl -sF 'f:1=<-' ix.io | pbcopy
# 	# read -r -d '' VAR << 'EOF' | gpg --encrypt --armor -r $EMAIL | curl -sF 'f:1=<-' ix.io | pbcopy
# }

gpg-decrypt-paste() {
	pbpaste | gpg --decrypt
}

gpg-decrypt-url() {
	curl $(pbpaste) | gpg --decrypt
}
