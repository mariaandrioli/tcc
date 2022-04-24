#!/bin/bash
FILES="*/*.log"
REGEX="[0-9]+"
for f in $FILES
do
  LINE="$(grep 'Total time spent by all map tasks' $f)"
  # take action on each file. $f store current file name
  time_secs=`echo "scale=2;${LINE//[!0-9]/}/1000" | bc`
  echo "$f MAP TIME: ${time_secs}"
#   cat "$f"
done