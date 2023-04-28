# Configure XDG autostart
{% for entry in pillar['xdg_autostart']['disabled_entries'] %}
{{ pillar.xdg_autostart.system_autostart_dir }}/{{ entry }}:
  file.exists

{% for user in pillar['users']['users'].values() %}
{{ user.home }}/{{ pillar.xdg_autostart.user_autostart_dir }}/{{ entry }}:
  file.managed:
    - user: {{ user.name }}
    - group: {{ user.name }}
    - source: salt://xdg-autostart/disable-entry.desktop
    - makedirs: True
    - require:
      - file: {{ pillar.xdg_autostart.system_autostart_dir }}/{{ entry }}
{% endfor %}
{% endfor %}
