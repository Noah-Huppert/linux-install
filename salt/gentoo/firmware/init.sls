# Install device firmware
{% for pkg in pillar['firmware']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Set modprobe files
{{ pillar.firmware.modprobe_dir }}:
  file.recurse:
    - source: salt://firmware/modprobe.d