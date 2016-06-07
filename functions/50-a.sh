a () {
  case $1 in
    (generate) echo generate ;; # routes, crud
    (db)       echo db ;; # manage models
    (dev)      echo dev ;; # build, test, update
    (help)     echo "Usage: $0 [generate|db|dev|help]" ;; # build, test, update
    (*)        a help
  esac
}

a-db () {
  
}
