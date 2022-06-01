#!/bin/bash

PATH_TO_CSV=$1
MESSAGE="Hello from Shell Script https://google.com"

# Make sure that osascript is installed
if ! [ -x $(command -v osascript) ]; then 
  echo "Command 'osascript' is required for this program. Aborting!" 
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
