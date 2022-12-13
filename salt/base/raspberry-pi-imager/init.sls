# Installs rpi-imager from xbps.
# src=SRC
{% for pkg in pillar['raspberry-pi-imager']['xbps_raspberry-pi-imager_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
