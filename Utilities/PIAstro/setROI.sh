#!/bin/bash

HOST=10.42.0.1
PORT=7624

ROI=$1
if [ -z $ROI ]
then
  ROI="0,0"
fi

netcat -w 5 $HOST $PORT <<EOF
<newTextVector
  device='Canon DSLR EOS 1200D'
  name='eoszoomposition'
>  <oneText
    name='eoszoomposition'>
 $ROI
</oneText>
</newTextVector>

EOF

