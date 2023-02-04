# Installs psmisc from xbps.
# src=xbps
{% for pkg in pillar['ps-tools']['xbps_ps-tools_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
