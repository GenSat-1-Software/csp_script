#!/bin/bash

process_name="./core-cpu3"
restart_delay=5
loop_delay=5
optionstring=":e:p:d:h"

function display_usage {
    echo "Usage: $0 [-e executable] [-p check_period_in_sec] [-d restart_delay_sec]"
}

while getopts $optionstring opt; do
    case $opt in
        e)
            if [ -x "$OPTARG" ] && [ -f "$OPTARG" ] ; then
                echo "process = $OPTARG"
                process_name="$OPTARG"
            else
                echo "$OPTARG is not an valid path or is not executable"
                display_usage
                exit 19 
            fi
            ;;
        p)
            if [[ "$OPTARG" =~ ^[0-9]+$ ]] && [  "$OPTARG" -ge 0 ] && [  "$OPTARG" -le 30 ]; then
                echo "loop_delay = $OPTARG"
                loop_delay="$OPTARG";
            else
                echo "$OPTARG is an invalid input for loop period"
                display_usage
                exit 20
            fi
            ;;
        d)
            if [[ "$OPTARG" =~ ^[0-9]+$ ]] && [  "$OPTARG" -ge 0 ] && [  "$OPTARG" -le 30 ]; then
                echo "restart_delay = $OPTARG"
                restart_delay="$OPTARG";
            else
                echo "$OPTARG is an invalid input for restart delay"
                display_usage
                exit 21
            fi
            ;;
        h) 
            display_usage
            exit 0
            ;;
        :)
            echo "missing an argument"
            display_usage
            exit 18
            ;;
        ?)
            echo "Invalid argument $OPTARG"
            display_usage
            exit 17
            ;;
    esac
done

while true; do

    if pgrep -x "$(basename $process_name)" > /dev/null; then
        echo "$process_name is running..."
    else
        echo "$process_name is not running..."
        
        for ((i = restart_delay; i > 0; i -= 2 )) do
            echo "$process_name will restart in $i seconds..."
            sleep 2
        done
        sudo "$process_name" &
    fi
    sleep "$loop_delay"

done
