#!/bin/bash

HOST=10.42.0.1
PORT=7624

ZOOM=$1
if [ -z $ZOOM ]
then
  ZOOM=1
fi

netcat -w 5 $HOST $PORT <<EOF
<newTextVector
  device='Canon DSLR EOS 1200D'
  name='eoszoom'
>  <oneText
    name='eoszoom'>
      $ZOOM
  </oneText>
</newTextVector>

EOF
