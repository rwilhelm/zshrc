function bidos () {

  cd ~bidos || (echo "bidos not found"; return)

  usage="Usage: $0 [api|www] [dev]"

  if [[ $# -eq 0 ]]; then
    echo $usage; return
  fi

  if [[ $1 == "-n" ]]; then
    noop=echo; shift
  fi

  if [[ $1 == "api" ]]; then
    server=api; shift
  elif [[ $1 == "www" ]]; then
    server=www; shift
  else
    echo $usage; return
  fi

  if [[ $1 == "dev" ]]; then
    NODE_ENV=development; shift
  elif [[ ! $1 ]]; then
    NODE_ENV=production
  else
    echo $usage; return
  fi

  export NODE_ENV

  case $NODE_ENV in
    development) node_env="\e[31m$NODE_ENV\e[00m" ;;
    production) node_env="\e[32m$NODE_ENV\e[00m" ;;
  esac

  echo "run bidos \e[34m$server\e[00m server in $node_env mode?"; read

  [[ $server == "www" ]] && [[ $NODE_ENV == "development" ]] && unset server

  $noop gulp $server
}

function bidos-db () {
  psql bidos_development
}

function bidos-update () {
  cd ~bidos
  npm-check-updates -u
  npm install
  bower update
}

function bidos-deploy () {
  rsync -av ~bidos bidos.uni-koblenz.de:
}

function bidos-remote-pull () {
  ssh bidos.uni-koblenz.de 'cd bidos && git pull'
}

function bidos-push () {
  cd ~bidos
  git status
  echo 'next: git add .'
  read
  git add .
  echo 'next: git commit -a'
  read
  git commit -a
  echo 'next: git push'
  read
  git push
}

function bidos-status () {
  echo "NODE_ENV=development"

  if [[ $(lsof -i :3010) ]]; then
    echo "bidos api \e[32monline\e[00m \e[34mhttp://localhost:3010\e[00m"
  else
    echo "bidos api \e[31moffline\e[00m"
  fi

  if [[ $(lsof -i :3011) ]]; then
    echo "bidos www \e[32monline\e[00m \e[34mhttp://localhost:3011\e[00m"
  else
    echo "bidos www \e[31moffline\e[00m"
  fi

  if [[ $(psql -lqt | cut -d \| -f 1 | grep -w bidos_development | wc -l) ]]; then
    echo "bidos db \e[32monline\e[00m"
  else
    echo "bidos db \e[31moffline\e[00m"
  fi
}
