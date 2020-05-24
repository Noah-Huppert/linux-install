#!/usr/bin/env bash
# Sets mods up if needed, runs minecraft.

# Helpers
function die() {
    echo "Error: $@" >&2
    exit 1
} 

# Ensure directories exist
MODS_FLAG_DIR="$HOME/.minecraft/.custom-launcher-script-mods-statuses"
MODS_DIR="$HOME/.minecraft/mods"
SHADERS_DIR="$HOME/.minecraft/shaderpacks"

for dir in "$MODS_FLAG_DIR" "$MODS_DIR" "$SHADERS_DIR"; do
    if [ ! -d "$dir" ]; then
	   if ! mkdir -p "$dir"; then
		  die "Failed to create directory \"$dir\""
	   fi
    fi
done

# Install mods if needed
{% for mod in pillar['minecraft']['mods'] %}
{% if mod['install'] == 'jar' %}
if [ ! -f "$MODS_FLAG_DIR/{{ mod['install_flag_file'] }}" ]; then
    if ! java -jar "{{ pillar['minecraft']['mods_dir'] }}/{{ mod['dest'] }}"; then
	   die "Failed to run mod jar {{ mod['dest'] }}"
    fi

    touch "$MODS_FLAG_DIR/{{ mod['install_flag_file'] }}"
fi
{% elif mod['install'] == 'copy-mods' %}
if [ ! -f "$MODS_DIR/{{ mod['dest'] }}" ]; then
    if ! cp "{{ pillar['minecraft']['mods_dir'] }}/{{ mod['dest'] }}" "$MODS_DIR/{{ mod['dest'] }}"; then
	   die "Failed to copy mod file {{ mod['dest'] }}"
    fi
fi
{% elif mod['install'] == 'copy-shaders' %}
if [ ! -f "$SHADERS_DIR/{{ mod['dest'] }}" ]; then
    if ! cp "{{ pillar['minecraft']['mods_dir'] }}/{{ mod['dest'] }}" "$SHADERS_DIR/{{ mod['dest'] }}"; then
	   die "Failed to copy shaders file {{ mod['dest'] }}"
    fi
fi
{% endif %}
{% endfor %}

# Run launcher
{{ pillar['minecraft']['launcher_bin'] }}
