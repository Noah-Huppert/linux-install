# Installs subversion from xbps.
# src=SRC
{% for pkg in pillar['subversion']['xbps_subversion_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
