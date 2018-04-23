#!/bin/bash

#Disable Liveview
#

FORMAT=`indi_getprop "Canon DSLR EOS 1200D".CAPTURE_FORMAT.*|grep On|tail -1|cut -d . -f 3`
indi_setprop "Canon DSLR EOS 1200D".CCD_VIDEO_STREAM.STREAM_OFF=On
indi_setprop "Canon DSLR EOS 1200D".CONNECTION.DISCONNECT=On

sleep 3

indi_setprop "Canon DSLR EOS 1200D".CONNECTION.CONNECT=On
indi_setprop "Canon DSLR EOS 1200D.CAPTURE_FORMAT.${FORMAT}"
