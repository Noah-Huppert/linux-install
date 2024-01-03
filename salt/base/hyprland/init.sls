# Install Hyprland window manager
hyprland_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.hyprland.pkgs }}

hyprland_aux_pkgs:
  {{ pillar.hyprland.aux_pkgs_state }}.installed:
    - pkgs: {{ pillar.hyprland.aux_pkgs }}

{{ pillar.hyprland.scripts_dir }}:
  file.recurse:
    - source: salt://hyprland/scripts
    - clean: True
    - makedirs: True
    - dir_mode: 655
    - file_mode: 755

{{ pillar.hyprland.lock_background_path }}:
  file.symlink:
    - target: {{ pillar.rice.images_directory }}/{{ pillar.rice.lock_img }}
    - makedirs: True

{{ pillar.hyprland.icons_dir }}:
  file.recurse:
    - source: salt://hyprland/icons
    - dir_mode: 755
    - file_mode: 655

{% for user in pillar['users']['users'].values() %}
{% for config_file in pillar['hyprland']['config_files'] %}
{{ user['home'] }}/{{ config_file['destination'] }}:
  file.managed:
    - source: {{ config_file['source'] }}
    - template: jinja
    - user: {{ user['name'] }}
    - group: {{ user['name'] }}
    - makedirs: True
    - requires:
      - pkg: hyprland_pkgs
      - {{ pillar.hyprland.aux_pkgs_state }}: hyprland_aux_pkgs

{% endfor %}
{% endfor %}
