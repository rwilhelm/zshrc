alias tc="/Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt --text"

mnt () {
  tc --mount $1 $2
}

x1500 () {
  diskutil list | awk '/\*1.5 TB/{printf("/dev/%s\n", $NF)}'
}

x2000 () {
  diskutil list | awk '/\*2.0 TB/{printf("/dev/%s\n", $NF)}'
}

mount-stuff () {
  echo x1500; mnt $(x1500) /Volumes/x1500
  echo x2000; mnt $(x2000) /Volumes/x2000
}
