# Installs qmk from xbps.
# src=xbps
{% for pkg in pillar['qmk']['xbps_qmk_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
