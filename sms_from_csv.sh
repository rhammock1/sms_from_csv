#!/bin/bash

PATH_TO_CSV=$1
MESSAGE="Hello from Shell Script"

while IFS="," read -r phone_number
do
  NUMBER=${phone_number//[^[:digit:].-]/}
  echo "Texting $NUMBER"
  osascript -e "tell application \"Messages\" to send \"$MESSAGE\" to buddy \"$NUMBER\""
done < <(tail -n +2 $PATH_TO_CSV)
