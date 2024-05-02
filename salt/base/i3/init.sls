# Install and configure i3

# Install
i3_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.i3.pkgs }}

i3_aux_pkgs:
  {{ pillar.i3.aux_pkgs_state }}.installed:
    - pkgs: {{ pillar.i3.aux_pkgs }}

# Scripts
{{ pillar.i3.scripts_dir }}:
  file.recurse:
    - source: salt://i3/scripts
    - clean: True
    - makedirs: True
    - dir_mode: 655
    - file_mode: 755

# Configuration files
{% for user in pillar['users']['users'].values() %}
{% for config_file in pillar['i3']['config_files'] %}
{{ user['home'] }}/{{ config_file['destination'] }}:
  file.managed:
    - source: {{ config_file['source'] }}
    - template: jinja
    - user: {{ user['name'] }}
    - group: {{ user['name'] }}
    - makedirs: True
    - requires:
      - pkg: i3_pkgs
{% endfor %}
{% endfor %}
