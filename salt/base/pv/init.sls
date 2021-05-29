# Installs pv from xbps.
# src=SRC
{% for pkg in pillar['pv']['xbps_pv_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
