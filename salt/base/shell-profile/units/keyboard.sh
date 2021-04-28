#!/usr/bin/env bash
if [ -n "$DISPLAY" ]; then
    setxkbmap -layout us,es -variant ,winkeys -model pc105 -option grp:ctrls_toggle
fi
