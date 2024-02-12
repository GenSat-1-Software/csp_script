#!/bin/bash

process_name="./core-cpu3"
restart_delay=5
loop_delay=5

while true; do

    if pgrep -x $process_name > /dev/null; then
        echo "$process_name is running..."
    else
        echo "$process_name is no running..."
        echo "$process_name will restart in $restart_delay"
        sleep $restart_delay 
        sudo $process_name
    fi
    sleep $loop_delay

done