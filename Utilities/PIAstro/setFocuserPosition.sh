#!/bin/bash

HOST=10.42.0.1

POS=$1
if [ -z $POS ]
then
  POS=0
fi

timeout 3 indi_setprop -h $HOST "LDM Focuser.ABS_FOCUS_POSITION.FOCUS_ABSOLUTE_POSITION=$POS"
