#!/bin/bash

ssh leone@10.42.0.1 -o ConnectTimeout=5 "sudo date `date +'%m%d%H%M%Y.%S'`" >/tmp/PIAstro$$.tmp 2>&1
yad --text-info --title "SetDate" --timeout=5 --width=450 --filename=/tmp/PIAstro$$.tmp
rm -f /tmp/PIAstro$$.tmp
