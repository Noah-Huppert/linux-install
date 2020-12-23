# Installs wayland, sway, kde from xbps.
{% for pkg in pillar['wayland']['xbps_wayland_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
