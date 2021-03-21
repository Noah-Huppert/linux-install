# Installs automake from xbps.
# src=SRC
{% for pkg in pillar['automake']['xbps_automake_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
