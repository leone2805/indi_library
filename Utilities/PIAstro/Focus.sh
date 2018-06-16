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

POS=$2
if [ -z $POS ]
then
  POS=0
fi

timeout 3 indi_setprop -h $HOST "LDM Focuser.FOCUS_MOTION.FOCUS_INWARD=Off"
timeout 3 indi_setprop -h $HOST "LDM Focuser.FOCUS_MOTION.FOCUS_OUTWARD=Off"
timeout 3 indi_setprop -h $HOST "LDM Focuser.REL_FOCUS_POSITION.FOCUS_RELATIVE_POSITION=$POS"

timeout 3 indi_setprop -h $HOST "LDM Focuser.FOCUS_MOTION.FOCUS_${DIR}WARD=On"
