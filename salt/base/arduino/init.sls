# Installs arduino from xbps.
# src=SRC
{% for pkg in pillar['arduino']['xbps_arduino_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
