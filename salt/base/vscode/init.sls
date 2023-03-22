# Installs vscode.
{% for pkg in pillar['vscode']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{{ pillar.vscode.desktop_file }}:
  file.managed:
    - source: salt://vscode/code-oss.desktop
