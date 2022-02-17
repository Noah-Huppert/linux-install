# Installs paprefs from xbps.
# src=SRC
{% for pkg in pillar['paprefs']['xbps_paprefs_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
