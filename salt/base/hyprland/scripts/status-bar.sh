#!/usr/bin/env bash
pkill waybar || true
waybar &
nwg-panel bottom &
