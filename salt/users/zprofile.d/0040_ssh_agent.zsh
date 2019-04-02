# Start SSH agent if one hasn't been started, or load configuration about 
# already running agent

# Location of file which will have information about a currently running 
# ssh agent
ssh_agent_info_f="$XDG_CONFIG_HOME/running-ssh-agent-info"

# Check to see if ssh-agent is running for user
if ! pgrep -u "$USER" ssh-agent &> /dev/null; then
	# If not running, run and save info to file
	ssh-agent > "$ssh_agent_info_f"
fi

# If environment doesn't contain ssh-agent information
if [ -z "$SSH_AGENT_PID" ]; then
	. "$ssh_agent_info_f" > /dev/null
fi
