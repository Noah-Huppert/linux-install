#!/usr/bin/env bash
CMD="$1"
if [[ -z "$CMD" ]]; then
    echo "Error: CMD positional argument required" >&2
    exit 1
fi

NWG_DRAWER_ARGS="-mb 100 -mt 100 -ml 100 -mr 100 -c 5"

set -x
if [[ "$CMD" == "launch" ]]; then
    nwg-drawer $NWG_DRAWER_ARGS
elif [[ "$CMD" == "preload" ]]; then
    nwg-drawer $NWG_DRAWER_ARGS -r
else
    echo "Error: Unknown CMD '$CMD'" >&2
    exit 1
fi
