#!/bin/bash

HOST=10.42.0.1
{
timeout 2 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CCD_INFO.CCD_MAX_X=5196
timeout 2 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CCD_INFO.CCD_MAX_Y=3464
timeout 2 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CCD_INFO.CCD_PIXEL_SIZE=4.29
timeout 2 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CCD_INFO.CCD_PIXEL_SIZE_X=4.29
timeout 2 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CCD_INFO.CCD_PIXEL_SIZE_Y=4.29
timeout 2 indi_setprop -h $HOST "Canon DSLR EOS 1200D".CCD_INFO.CCD_BITSPERPIXEL=8
} >/tmp/PIAstro$$.tmp 2>&1

if [ -s /tmp/PIAstro$$.tmp ]
then
  yad --text-info --title "setCCD" --width=450 --filename=/tmp/PIAstro$$.tmp
fi

rm -f /tmp/PIAstro$$.tmp
