#!/usr/bin/env bash
# Import the WAYLAND_DISPLAY env var from sway into the systemd user session.
set -x
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway

# Stop any services that are running, so that they receive the new env var when they restart.
systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
systemctl --user start wireplumber
