#!/usr/bin/env bash
# Sets mods up if needed, runs minecraft.

# Helpers
function die() {
    echo "Error: $@" >&2
    exit 1
} 

# Ensure directories exist
MODS_FLAG_DIR="$HOME/.minecraft/.custom-launcher-script-mods-statuses"
if [ ! -d "$MODS_FLAG_DIR" ]; then
    if ! mkdir -p "$MODS_FLAG_DIR"; then
	   die "Failed to create mods flag directory"
    fi
fi

MODS_DIR="$HOME/.minecraft/mods"
if [ ! -d "$MODS_DIR" ]; then
    if ! mkdir -p "$MODS_DIR"; then
	   die "Failed to create mods directory"
    fi
fi

# Install mods if needed
{% for mod in pillar['minecraft']['mods'] %}
{% if mod['install'] == 'jar' %}
if [ ! -f "$MODS_FLAG_DIR/{{ mod['install_flag_file'] }}" ]; then
    if ! java -jar "{{ pillar['minecraft']['mods_dir'] }}/{{ mod['dest'] }}"; then
	   die "Failed to run mod jar {{ mod['dest'] }}"
    fi

    touch "$MODS_FLAG_DIR/{{ mod['install_flag_file'] }}"
fi
{% elif mod['install'] == 'copy' %}
if [ ! -f "$MODS_DIR/{{ mod['dest'] }}" ]; then
    if ! cp "{{ pillar['minecraft']['mods_dir'] }}/{{ mod['dest'] }}" "$MODS_DIR/{{ mod['dest'] }}"; then
	   die "Failed to copy mod file {{ mod['dest'] }}"
    fi
fi
{% endif %}
{% endfor %}

# Run launcher
{{ pillar['minecraft']['launcher_bin'] }}
