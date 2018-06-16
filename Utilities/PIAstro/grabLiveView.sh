#!/bin/bash

HOST=10.42.0.1

timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D.CCD_VIDEO_STREAM.STREAM_ON=On"
sleep 2
wmctrl -a "Live"
timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_FILE.RECORD_FILE_DIR=/tmp"
timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_FILE.RECORD_FILE_NAME=indi_record"

timeout 3 indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_OPTIONS.RECORD_FRAME_TOTAL=1"
timeout 5 indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_STREAM.RECORD_FRAME_ON=On"
scp leone@$HOST:/tmp/indi_record.ser .
ssh leone@$HOST -o ConnectTimeout=5 "rm /tmp/indi_record.ser"
wmctrl -a "Live"
ROI=`python ~/PIAstro/getROI.py`
~/PIAstro/setZoom.sh 1
~/PIAstro/setZoom.sh 5
~/PIAstro/setROI.sh $ROI
wmctrl -a "PIAstro"
exit 0
while :
do
  wmctrl -a "Live"
  ROI=`python ~/PIAstro/getROI.py`
  ~/PIAstro/setROI.sh $ROI
done
