#!/bin/bash

old_time=100

while true;
do
  indi_eval -t 0 -wo '"Simple CCD.CCD_EXPOSURE.CCD_EXPOSURE_VALUE">0' 2>/run/shm/exposure.txt
  exposure=`tail -1 /run/shm/exposure.txt |cut -d = -f 2`
  time=`echo "$exposure * 1000000" | bc -l|cut -d . -f 1`
  echo "Exposure=$exposure ($time)"
  if [ $old_time -ne $time ]
  then
    echo -n "0 0 1 1 $time" >/run/shm/camera_params.txt
    old_time=$time
  else
    echo "Exposure unchanged"
  fi
  sleep 1
  echo "Waiting for 0"
  indi_eval -t 0 -w '"Simple CCD.CCD_EXPOSURE.CCD_EXPOSURE_VALUE"==0'
  echo "Waiting for exposure"
done
