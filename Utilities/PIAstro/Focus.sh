#!/bin/bash

HOST=10.42.0.1

DIR=$1
case $DIR in 
  IN|OUT) 
    ;;
  *)
    echo "Possible parameters: IN,OUT"
    exit 1 ;;
esac

indi_setprop -h $HOST "LDM Focuser.FOCUS_MOTION.FOCUS_${DIR}WARD=On"
