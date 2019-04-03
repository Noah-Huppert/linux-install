# Check if TMux is not running
if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
	# Start TMux and exit when TMux exits
	exec tmux
elif [ -n "$TMUX" ]; then # If TMux is already running
	# Source configuration file
	tmux source-file "{{ pillar.tmux.configuration_file }}"
fi
