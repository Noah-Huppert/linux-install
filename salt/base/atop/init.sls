# Installs atop from xbps.
# src=xbps
{% for pkg in pillar['atop']['xbps_atop_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
