#!/bin/bash

HOST=10.42.0.1

indi_setprop -h $HOST "Canon DSLR EOS 1200D.CCD_VIDEO_STREAM.STREAM_ON=On"
sleep 2
wmctrl -a "Live"
indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_FILE.RECORD_FILE_DIR=/tmp"
indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_FILE.RECORD_FILE_NAME=indi_record"

indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_OPTIONS.RECORD_FRAME_TOTAL=1"
indi_setprop -h $HOST "Canon DSLR EOS 1200D.RECORD_STREAM.RECORD_FRAME_ON=On"
scp leone@$HOST:/tmp/indi_record.ser .
ssh leone@$HOST "rm /tmp/indi_record.ser"
wmctrl -a "Live"
ROI=`python getROI.py`
./setZoom.sh 1
./setZoom.sh 5
./setROI $ROI

while :
do
  wmctrl -a "Live"
  ROI=`python getROI.py`
  ./setROI $ROI  
done
