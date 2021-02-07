# Installs kodi from xbps.
# src=SRC
{% for pkg in pillar['kodi']['xbps_kodi_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
