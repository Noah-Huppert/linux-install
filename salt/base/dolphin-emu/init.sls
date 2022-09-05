# Installs dolphin-emu from xbps.
# src=SRC
{% for pkg in pillar['dolphin-emu']['xbps_dolphin-emu_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
