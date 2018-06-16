#!/bin/bash

HOST=10.42.0.1

{
ssh leone@$HOST -o ConnectTimeout=5 "free -m"
FORMAT=`timeout 3 indi_getprop -h $HOST "Canon DSLR EOS 1200D".CAPTURE_FORMAT.*|grep On|tail -1|cut -d . -f 3`
if [ -z "$FORMAT" ]
then
  echo "Host $HOST unreachable"
else
  timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CONNECTION.DISCONNECT=On
  sleep 2
  ssh leone@$HOST -o ConnectTimeout=5 "pkill -HUP indi_canon_ccd"
  sleep 2
  timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CONNECTION.CONNECT=On
  timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D.CAPTURE_FORMAT.${FORMAT}"
  ssh leone@$HOST -o ConnectTimeout=5 "free -m"
fi
} >/tmp/PIAstro$$.tmp 2>&1

yad --text-info --title "FreeMem" --width=450 --filename=/tmp/PIAstro$$.tmp
rm -f /tmp/PIAstro$$.tmp
