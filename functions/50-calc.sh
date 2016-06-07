tickets () {
  amount=${1}
  dosage=${2}.0
  eur=${3}
  cat << EOF
  $amount tickets
  $dosage ug/ticket

  $amount tickets => EUR $eur => $(( $amount*$dosage )) ug
  1 ticket => EUR $(( $eur/$amount )) => $dosage ug
  1 ug => EUR $(( $eur/($amount*$dosage) ))

EOF
}
