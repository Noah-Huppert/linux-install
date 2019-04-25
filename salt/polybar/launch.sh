#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.01; done

# Launch primary bar
echo "Launching bar on eDP-1"

MONITOR=eDP-1 polybar primary -r & disown 

if ! xrandr -q | grep "HDMI1 connected (" &> /dev/null; then
    echo "Launching br on HDMI1"
    
    MONITOR=HDMI1 polybar primary -r & disown
fi

