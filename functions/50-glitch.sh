txtedit () {
  cp $1 ${1:r}$(now s).${1:e}
  mv $1 ${1:r}.txt
  subl -nw ${1:r}.txt
  mv ${1:r}.txt $1
  qlmanage -p $1
}

alias zalgo="zalgolize"

delete-random-line () {
  ctime=$(zstat -F '%Y%m%d%H%M%S' +ctime -- $1);
  md5hash=$(md5 $1 | cut -d\  -f4);
  \cp -n $1 $ctime-$md5hash.${1:e}
  length=$((`cat $1 | wc -l`));
  lower=$(($length/4));
  upper=$((($lower/2)*4));
  random_line=$(($lower + RANDOM % $upper))
  echo $length $lower $upper $random_line;
  sed -i ${random_line}d $1
}

hexrnddd () {
  ctime=$(zstat -F '%Y%m%d%H%M%S' +ctime -- $1);
  md5hash=$(md5 $1 | cut -d\  -f4);
  \cp -n $1 $ctime-$md5hash.${1:e}
  length=$((`xxd $1 | wc -l`));
  lower=$(($length/4));
  upper=$((($lower/2)*7));
  random_line=$(($lower + RANDOM % $upper))
  echo $length $lower $upper $random_line;
  tmp=__$(now s).${1:e}
  xxd $1 | sed ${random_line}d | xxd -r > $tmp
  \mv $tmp $1
}

convert-to-raw () {
  bytes=$(identify -format "%[fx:h*w*2]" $1 | awk '{printf("%d\n", $1)}')
  raw=${1:r}.raw
  convert $1 -depth 16 pgm:- | tail -c $bytes > $raw
}

xxdrnddd () {
  ctime=$(zstat -F '%Y%m%d%H%M%S' +ctime -- $1);
  md5hash=$(md5 $1 | cut -d\  -f4);
  \cp -n $1 $ctime-$md5hash.${1:e}
  length=$((`xxd $1 | wc -l`));
  lower=$(($length/4));
  upper=$((($lower/2)*7));
  random_line=$(($lower + RANDOM % $upper))
  echo $length $lower $upper $random_line;
  tmp=__$(now s).${1:e}
  src=$1
  # convert-to-raw $1
  # src=${1:r}.raw
  # test -f $src || return
  xxd -p $src | sed ${random_line},$((${random_line} + 3))s/ae/ea/g | xxd -r -ps >| $tmp
  \mv $tmp $1
}
