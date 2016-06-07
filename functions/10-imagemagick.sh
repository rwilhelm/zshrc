#
# Imagemagick / Graphicsmagick functions
# Last update: 2014-05-10-15-37-53
# Copyright 2014 (c) rene.wilhelm@gmail.com
#

function bla() {
  gm convert $1 -trim $1
  gm convert $1 -bordercolor white -border 16 $1
}