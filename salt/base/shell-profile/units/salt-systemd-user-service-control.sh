# Looks in the salt systemd user service control directory and applies the desired operations to each user service
# Only runs once per boot, checks the SHELL_PROFILE_SALT_SYSTEMD_USER_SERVICE_CONTROL env var.

salt_systemd_user_service_control_units="~/{{ pillar.salt_systemd_user_service_control.user_config_dir }}"
salt_systems_user_service_control_script="{{ pillar.salt_systemd_user_service_control.script_path }}"

if [[ -n "$SHELL_PROFILE_SALT_SYSTEMD_USER_SERVICE_CONTROL" ]]; then
    # Already run
    return
fi

while read user_unit_file; do
    unit_name=$(basename "$user_unit_file")
    ops=$(cat "$user_unit_file")
    
    # Check if unit in correct state
    if ! eval "$salt_systems_user_service_control_script" -c -u "$unit_name" "$ops"; then
	# If not then apply change
	eval "$salt_systems_user_service_control_script" -u "$unit_name" "$ops"
    fi
done <<< $(find "$salt_systemd_user_service_control_units" -mindepth 1 -maxdepth 1)

# Mark as run so we don't do this again
export SHELL_PROFILE_SALT_SYSTEMD_USER_SERVICE_CONTROL="y"
