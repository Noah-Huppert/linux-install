# Installs vscode.
{% for pkg in pillar['vscode']['pkgs'] %}
{{ pkg }}:
  {{ pillar.vscode.pkgs_state }}.installed
{% endfor %}

{% for name, user in pillar['users']['users'].items() %}
{{ user['home'] }}/{{ pillar.vscode.user_settings_file }}:
  file.managed:
    - makedirs: True
    - source: salt://vscode/settings.json
    - replace: False
    - user: {{ user.name }}
    - group: {{ user.name }}
    - requires:
      - pkg: vscode_pkgs
{% endfor %}

{% if pillar['vscode']['oss_desktop_file'] is not none %}
{{ pillar.vscode.oss_desktop_file }}:
  file.managed:
    - source: salt://vscode/code-oss.desktop
{% endif %}

{% if pillar['vscode']['msfs_desktop_file'] is not none %}
{{ pillar.vscode.msfs_desktop_file }}:
  file.managed:
    - source: salt://vscode/msfs-code.desktop
{% endif %}
