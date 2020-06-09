# Check if TMux is not running
if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
	# Start TMux and exit when TMux exits
	exec tmux
fi
