#!/bin/bash

FILES="*.log"
REGEX="[0-9]+"
for f in $FILES
do
  LINE="$(grep 'Total time spent by all map tasks' $f)"
  LINE2="$(grep 'Total time spent by all reduce tasks' $f)"
  # take action on each file. $f store current file name
  time_secs1=`echo "scale=2;${LINE//[!0-9]/}/1000" | bc`
  time_secs2=`echo "scale=2;${LINE2//[!0-9]/}/1000" | bc`
  sum=$(echo "$time_secs1 + $time_secs2" | bc)
  # echo "$f MAP TIME:"
  echo "$f: ${sum}"
#   cat "$f"
done