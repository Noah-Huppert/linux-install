# Install Hyprland window manager
hyprland_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.hyprland.pkgs }}

hyprland_aux_pkgs:
  {{ pillar.hyprland.aux_pkgs_state }}.installed:
    - pkgs: {{ pillar.hyprland.aux_pkgs }}

{{ pillar.hyprland.scripts_dir }}:
  file.recurse:
    - source: salt://hyrpland/scripts
    - makedirs: True
    - dir_mode: 644
    - file_mode: 755

{% for user in pillar['users']['users'].values() %}
{{ user['home'] }}/{{ pillar.hyprland.hyprland_config_file }}:
  file.managed:
    - source: salt://hyprland/conf/hyprland.conf
    - template: jinja
    - user: {{ user['name'] }}
    - group: {{ user['name'] }}
    - makedirs: True

{{ user['home'] }}/{{ pillar.hyprland.hyprpaper_config_file }}:
  file.managed:
    - source: salt://hyprland/conf/hyprpaper.conf
    - template: jinja
    - user: {{ user['name'] }}
    - group: {{ user['name'] }}
    - makedirs: True
{% endfor %}
