# Installs xtools from xbps.
# src=SRC
{% for pkg in pillar['xtools']['xbps_xtools_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
