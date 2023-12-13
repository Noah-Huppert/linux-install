vscode_pkgs:
  aurpkg.installed:
    - pkgs: {{ pillar.vscode.pkgs }}

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
