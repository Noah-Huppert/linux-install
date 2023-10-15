# Install Hyprland window manager
hyprland_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.hyprland.pkgs }}

{% for user in pillar['users']['users'].values() %}
{{ user['home'] }}/{{ pillar.hyprland.config_file }}:
  file.managed:
    - source: salt://hyprland/hyprland.conf
    - user: {{ user['name'] }}
    - group: {{ user['name'] }}
    - makedirs: True
{% endfor %}