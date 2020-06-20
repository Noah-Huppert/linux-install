# Check if TMux is not running and if we are in a visual environment
# The check for a visual environment is needed because if we start TMux before
# X is running then we won't be able to start X. Because X can only start in a plain
# old shell. 
if [ -z "$TMUX" ] && [ -n "$DISPLAY" ]; then
	# Start TMux (using exec so the shell exits when TMux exits)
	exec tmux
elif [ -n "$TMUX" ]; then # If TMux is already running
	# Source configuration file when zsh starts in TMux
	tmux source-file "{{ pillar.tmux.configuration_file }}"
fi
