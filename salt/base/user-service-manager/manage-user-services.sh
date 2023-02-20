#!/usr/bin/env bash
# Services are either enabled and running or disabled and stopped.

# Jinja Constants
declare -r service_config_dir="$HOME/{{ pillar.user_service_manager.services_config_dir }}"
declare -r last_run_services_file="$HOME/{{ pillar.user_service_manager.last_run_services_file }}"

# {% raw %}

# Exit codes
declare -ri EXIT_CODE_ENABLE_START_FAIL=10
declare -r EXIT_MSG_ENABLE_START_FAIL="Failed to enabled and start service"

declare -ri EXIT_CODE_START_FAIL=11
declare -r EXIT_MSG_START_FAIL="Failed to start service"

declare -ri EXIT_CODE_DISABLE_STOP_FAIL=12
declare -r EXIT_MSG_DISABLE_STOP_FAIL="Failed to disable and stop service"

declare -ri EXIT_CODE_RM_LAST_RUN_SERVICES_FAIL=20
declare -r EXIT_MSG_RM_LAST_RUN_SERVICES_FAIL="Failed to clear last run services file"

declare -ri EXIT_CODE_ECHO_LAST_RUN_SERVICES_FAIL=21
declare -r EXIT_MSG_ECHO_LAST_RUN_SERVICES_FAIL="Failed to record service in last run services file"

# Print error msg then exit with code
die() { # (code, msg)
    local -ri code="$1"
    local -r msg="$2"
    
    echo "Error: $msg" >&2
    exit $code
}

# Run command and die if fails
run_check() { # (cmd, code, msg, echo? )
    local -r cmd="$1"
    local -ri code="$2"
    local -r msg="$3"
    local -r echo="$4"

    if [[ -n "$echo" ]]; then
	echo "$cmd"
    fi

    if ! eval "$cmd"; then
	die "$code" "$msg"
    fi
}

# Make list of enabled services
declare -a enable_services=()

while read -r unit_ctrl_file; do
    if [[ -z "$unit_ctrl_file" ]]; then
	continue
    fi
    
    svc_name=$(basename "$unit_ctrl_file")
    enable_services+=("$svc_name")
done <<< $(find "$service_config_dir" -mindepth 1 -maxdepth 1 -type f)

echo "Want user services: ${enable_services[*]} (Count ${#enable_services[@]})"

# Make list of previously enabled services
declare -a last_run_services=()

if [[ -f "$last_run_services_file" ]]; then
    while read -r svc; do
	if [[ -z "$svc" ]]; then
	    continue
	fi

	last_run_services+=("$svc")
    done <<< $(cat "$last_run_services_file")
fi

# Enable and start services
for svc in "${enable_services[@]}"; do
    # Get current status
    enabled=""
    if systemctl is-enabled --user "$svc" &> /dev/null; then
	echo "$svc already enabled"
	enabled="y"
    fi

    active=""
    if systemctl is-active --user "$svc" &> /dev/null; then
	echo "$svc already running"
	active="y"
    fi

    # Start service if needed
    if [[ -z "$enabled" ]]; then
       run_check "systemctl enable --user --now '$svc'" "$EXIT_CODE_ENABLE_START_FAIL" "$EXIT_MSG_ENABLE_START_FAIL" "y"
    elif [[ -z "$active" ]]; then
	run_check "systemctl start --user '$svc'" "$EXIT_CODE_START_FAIL" "$EXIT_MSG_START_FAIL" "y"
    fi
done

# Disable and stop services
for svc in "${last_run_services[@]}"; do
    # Check if needs to be disabled
    if [[ ! " $svc " =~ " ${enable_services[*]} " ]]; then
	run_check "systemctl disable --user --now '$svc'" "$EXIT_CODE_DISABLE_STOP_FAIL" "$EXIT_MSG_DISABLE_STOP_FAIL" "y"
    fi
done

# Record this run's services
if [[ -f "$last_run_services_file" ]]; then
    run_check "rm '$last_run_services_file'" "$EXIT_CODE_RM_LAST_RUN_SERVICES_FAIL" "$EXIT_MSG_RM_LAST_RUN_SERVICES_FAIL"
fi

for svc in "${enable_services[@]}"; do
    run_check "echo '$svc' >> '$last_run_services_file'" "$EXIT_CODE_ECHO_LAST_RUN_SERVICES_FAIL" "$EXIT_MSG_ECHO_LAST_RUN_SERVICES_FAIL"l
done

# {% endraw %}
