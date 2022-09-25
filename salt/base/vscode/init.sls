# Installs vscode from xbps.
# src=SRC
{% for pkg in pillar['vscode']['xbps_vscode_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
