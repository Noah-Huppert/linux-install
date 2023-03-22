# Installs vscode.
{% for pkg in pillar['vscode']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% if pillar['vscode']['desktop_file'] is not none %}
{{ pillar.vscode.desktop_file }}:
  file.managed:
    - source: salt://vscode/code-oss.desktop
{% endif %}