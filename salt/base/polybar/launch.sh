#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.01; done

# Launch primary bar
while read -r disp; do
    echo "Launching bar on $disp"

    MONITOR="$disp" polybar primary -r & disown 
done <<<$(polybar -m | awk -F ':' '{ print $1 }')
