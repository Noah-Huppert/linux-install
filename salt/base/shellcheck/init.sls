# Installs shellcheck from xbps.
# src=SRC
{% for pkg in pillar['shellcheck']['xbps_shellcheck_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
