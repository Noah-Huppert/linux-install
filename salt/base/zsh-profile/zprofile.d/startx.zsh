# Tries to start an X server. If this fails it exits gracefully so the user can
# still rescue the session and use the terminal after.
if [ -z "$DISPLAY" ]; then
    if ! startx; then
	   return $(unit-die "Failed to start an X server")
    fi
fi
