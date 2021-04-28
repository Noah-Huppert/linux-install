# Installs perf from xbps.
# src=SRC
{% for pkg in pillar['perf-tool']['xbps_perf-tool_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
