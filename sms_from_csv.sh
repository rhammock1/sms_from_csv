#!/bin/bash

PATH_TO_CSV=''
PATH_TO_MESSAGE=''
MESSAGE=''

while test $# -gt 0
do
  case "$1" in
    --message | -m) PATH_TO_MESSAGE=$2
      ;;
    --csv | -c) PATH_TO_CSV=$2
      ;;
    --help | -h) cat help.txt
      exit 0
      ;;
    --*) echo "No such option: $1"
      exit 0
      ;;
  esac
  shift
done

# Make sure that osascript is installed
if ! [ -x $(command -v osascript) ]; then 
  echo "Command 'osascript' is required for this program. Aborting!" 
  exit 1
fi

if [[ $PATH_TO_MESSAGE != *.txt ]]; then
  echo "Please provide a txt file with the message to send."
  exit 1
elif [[ ! -f $PATH_TO_MESSAGE ]]; then
  echo "The txt file does not exist."
  exit 1
fi
MESSAGE=$(cat $PATH_TO_MESSAGE)

if [[ $PATH_TO_CSV != *.csv ]]; then
  echo "Please provide a csv file with the phone numbers to send to."
  exit 1
elif [[ ! -f $PATH_TO_CSV ]]; then
  echo "The csv file does not exist."
  exit 1
fi

while IFS="," read -r phone_number
do
  # remove any nondigits from the phone number
  NUMBER=${phone_number//[^[:digit:].-]/}

  echo "Texting $NUMBER"
  osascript -e "tell application \"Messages\" to send \"$MESSAGE\" to buddy \"$NUMBER\""

  # Sleep because I don't know what this will be like with lots of phone numbers
  sleep 0.5
done < $PATH_TO_CSV
