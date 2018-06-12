#!/bin/bash

HOST=10.42.0.1

DIM=$1
if [ -z $DIM ]
then
  DIM=6
fi

case $DIM in 
  smaller) 
    indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT6=On 
    ;;
  medium)
    indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT2=On 
    ;; 
  large)
    indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT0=On 
    ;; 
  raw)
    indi_setprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.FORMAT9=On 
    ;;
  *)
    echo "Possible parameters: smaller, medium, large, raw"
    ;;
esac
