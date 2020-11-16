# Manage user's Shell profiles
# State combines all the files in the salt://shell-profile/profile.d directory
# into one file and places this file as a user's Shell profile.
#
# Each of these files in the profile.d directory is called a Shell unit.

# This state was changed from being "zsh profile" specific to
# "shell profile" specific. This removes any remnants of the old setup.
{% for _, user in pillar['users']['users'].items() %}
# Shell profiles
{% set shell_profiles_dir = user.home + '/.zprofile.d' %}
{% set units_file = user.home + '/.zprofile.units' %}

{{ shell_profiles_dir }}:
  file.absent

{{ units_file }}:
  file.absent

{{ user.home }}/.zshrc:
  file.absent

{% endfor %}

/opt/bake-zprofiles:
  file.absent

# Bake Shell profiles script
{{ pillar.shell_profile.bake_script }}:
  file.managed:
    - source: salt://shell-profile/bake-profiles.sh
    - template: jinja
    - makedirs: True
    - mode: 755

# Configure users
{% for _, user in pillar['users']['users'].items() %}

{% set shell_profiles_dir = user.home + '/' + pillar['shell_profile']['shell_profiles_dir'] %}
{% set units_file = user.home + '/' + pillar['shell_profile']['units_file'] %}

{{ shell_profiles_dir }}:
  file.recurse:
    - source: salt://shell-profile/profile.d
    - clean: True
    - user: {{ user.name }}
    - group: {{ user.name }}
    - dir_mode: 755
    - file_mode: 755
    - template: jinja

{{ units_file }}:
  file.managed:
    - source: salt://shell-profile/profile.units
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 650

bake_shell_profiles-{{ user.name }}:
  cmd.run:
    - name: {{ pillar.shell_profile.bake_script }}
    - runas: {{ user.name }}
    - onchanges:
      - file: {{ pillar.shell_profile.bake_script }}
      - file: {{ shell_profiles_dir }}
      - file: {{ units_file }}
    - require:
      - file: {{ shell_profiles_dir }}
      - file: {{ pillar.shell_profile.bake_script }}
      - file: {{ units_file }}

{% endfor %}
