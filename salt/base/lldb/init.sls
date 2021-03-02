# Installs lldb from xbps.
# src=SRC
{% for pkg in pillar['lldb']['xbps_lldb_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
