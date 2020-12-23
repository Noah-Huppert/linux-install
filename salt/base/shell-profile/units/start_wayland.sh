# Tries to start wayland. If this fails it exits gracefully so the user can
# still rescue the session and use the terminal after.
# Shortcut
alias sw=start-wayland

if [ -z "$RUNNING_WAYLAND" ]; then
    if ! start-wayland; then
    	   return $(unit-die "Failed to start a wayland")
    fi
fi
