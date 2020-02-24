#!/bin/bash

set -e 

OPTIND=1

show_help() {
  echo "$0 -c <conf dir>"
}

while getopts ":p:c:q" opt; do
  case "$opt" in
    h|/?)
      echo "Unknown argument $OPTARG"
      show_help
      exit 0
      ;;
    c)
      conf="$(realpath $OPTARG)"
      ;;
  esac
done
shift $((OPTIND-1))
echo "Conf: $conf"

if [[ -z $conf ]]; then
  echo "snort conf is required"
  show_help
  exit 1
fi

if [[ ! -d $conf ]]; then
  echo "snort conf directoy is not accessible: $conf"
  exit 1
fi


docker run -it \
  -v $conf:/etc/snort \
  snort2 \
  /bin/bash

