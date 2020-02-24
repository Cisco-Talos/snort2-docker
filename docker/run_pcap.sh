#!/bin/bash

set -e 

OPTIND=1

show_help() {
  echo "$0 [-q] -c <conf dir> -p <pcap dir>"
}

while getopts ":p:c:q" opt; do
  case "$opt" in
    h|/?)
      echo "Unknown argument $OPTARG"
      show_help
      exit 0
      ;;
    p)
      pcap_dir="$(realpath $OPTARG)"
      ;;
    c)
      conf="$(realpath $OPTARG)"
      ;;
    q)
      quiet="-q"
      ;;
  esac
done
shift $((OPTIND-1))
echo "Pcaps: $pcap_dir"
echo "Conf: $conf"

if [[ -z $pcap_dir ]]; then
  echo "pcap directory is required"
  show_help
  exit 1
fi

if [[ ! -d $pcap_dir ]]; then
  echo "pcap directory is not accessible: $pcap_dir"
  show_help
  exit 1
fi

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
  -v $pcap_dir:/root/pcaps \
  snort2 \
  snort $quiet \
  -q \
  -N \
  -A cmg \
  -I \
  -c /etc/snort/snort.conf \
  -Q \
  --daq dump \
  --daq-var load-mode=read-file \
  --daq-var file=/dev/null \
  --pcap-filter="*.pcap" \
  --pcap-dir="/root/pcaps" \
  --pcap-reset \
  --pcap-show

