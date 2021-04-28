# Installs godot from xbps.
# src=SRC
{% for pkg in pillar['godot']['xbps_godot_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
