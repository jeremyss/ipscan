#!/usr/bin/env bash
DATE=`date +%m%d-%H%M%S`
unset $opt
function usage () {
        echo
        echo "USAGE"
        echo "ipscan OPTIONS {[file] [network]}"
        echo
        echo "OPTIONS"
        echo "-6 Scan IPv6 address space"
        echo "-n Scan network ex. 192.168.1.0/24"
        echo "-f Scan networks in file ex. /path/to/file/"
        echo "   file lists IPs in single column"
        echo "-h Help menu"
}

function scan () {
        echo "script running... please wait..."
        nmap $IPv6 -vv -sn -PS22,23,80,443,8080 -oG ipScan-$DATE.txt --append-output $network$file > /dev/null 2>&1
        echo
        echo -e "File saved to ipScan-$DATE.txt\n"
        echo -e "Use grep -i up ipScan-$DATE.txt to view ALIVE IPs\n"
}

while getopts ":f:n:6h" opt; do
 case $opt in
    f)
      file="-iL $OPTARG"
      ;;
    n)
      network="$OPTARG"
      ;;
    6)
      IPv6="-6"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
    h)
      usage
      exit 1
    ;;
  esac

done
if [ -z $1 ]
 then
  usage
  exit 1
elif [[ $1 == [0-9]* ]] || [[ $1 == [a-z]* ]]
 then
  usage
  exit 1
fi
scan