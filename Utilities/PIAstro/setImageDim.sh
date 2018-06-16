#!/bin/bash

HOST=10.42.0.1

DIM=$1
if [ -z $DIM ]
then
  DIM=6
fi
{
case $DIM in 
  smaller) 
    timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT6=On 
    ;;
  medium)
    timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT2=On 
    ;; 
  large)
    timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT0=On 
    ;; 
  raw)
    timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT9=On 
    ;;
  *)
    echo "Possible parameters: smaller, medium, large, raw"
    ;;
esac
} >/tmp/PIAstro$$.tmp 2>&1

if [ -s /tmp/PIAstro$$.tmp ]
then
  yad --text-info --title "SetImageDim" --width=450 --filename=/tmp/PIAstro$$.tmp
fi
rm -f /tmp/PIAstro$$.tmp
