#!/bin/bash

HOST=10.42.0.1

timeout 3 indi_setprop -h $HOST "LDM Focuser.FOCUS_RESET.FOCUS_RESET=On"
