# Installs graphiviz from xbps.
# src=SRC
{% for pkg in pillar['graphviz']['xbps_graphviz_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
