#!/bin/bash

HOST=10.42.0.1

FORMAT=`indi_getprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.*|grep On|tail -1|cut -d . -f 3`
indi_setprop -h $HOST "Canon DSLR EOS 1200D".CONNECTION.DISCONNECT=On
sleep 2
ssh leone@$HOST "pkill -HUP indi_canon_ccd"
sleep 2
indi_setprop -h $HOST "Canon DSLR EOS 1200D".CONNECTION.CONNECT=On
indi_setprop -h $HOST "Canon DSLR EOS 1200D.CAPTURE_FORMAT.${FORMAT}"
ssh leone@$HOST "free -m"
