#!/bin/bash

PATH_TO_CSV=$1
MESSAGE=''

# Make sure that osascript is installed
if ! [ -x $(command -v osascript) ]; then 
  echo "Command 'osascript' is required for this program. Aborting!" 
  exit 1
fi

if [[ $2 != *.txt ]]; then
  echo "Please provide a txt file with the message to send."
  exit 1
fi
MESSAGE=$(cat $2)

while IFS="," read -r phone_number
do
  # remove any nondigits from the phone number
  NUMBER=${phone_number//[^[:digit:].-]/}

  echo "Texting $NUMBER"
  osascript -e "tell application \"Messages\" to send \"$MESSAGE\" to buddy \"$NUMBER\""

  # Sleep because I don't know what this will be like with lots of phone numbers
  sleep 0.5
done < $PATH_TO_CSV
