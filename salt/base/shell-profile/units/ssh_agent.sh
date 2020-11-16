# Start SSH agent if login shell

# Configuration
agent_env_file="$HOME/.run/ssh-agent.env"

# Check if agent is already running
agent_pid=$(pgrep -u "$USER" ssh-agent)
get_agent_pid_status="$?"

if [[ $(echo "$agent_pid" | wc -l) != "1" ]]; then
    return $(unit-die "Too any SSH agents running with PIDs: $(echo $agent_pid | tr '\n' ' ')")
fi

if [[ "$get_agent_pid_status" != "0" ]]; then
    # If agent isn't running, start and save details
    if ! ssh-agent > "$agent_env_file"; then
	return $(unit-die "Failed to start ssh-agent")
    fi

    agent_pid=$(cat "$agent_env_file" | sed -n 's/SSH_AGENT_PID=\([0-9]*\);.*/\1/p')
fi

# If agent is already running, source file
eval $(cat "$agent_env_file") &> /dev/null

# Check that we have the details of the ssh-agent that we found running
if [[ "$agent_pid" != "$SSH_AGENT_PID" ]]; then
    return $(unit-die "Found running SSH agent with PID: $agent_pid, but have details for PID: $SSH_AGENT_PID")
fi
