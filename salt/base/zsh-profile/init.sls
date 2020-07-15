# Manage user's Zsh profiles
# State combines all the files in the salt://zsh-profile/zprofile.d directory
# into one file and places this file as a user's Zsh profile.
#
# Each of these files in the zprofile.d directory is called a Zsh unit.

# Bake Zsh profiles script
{{ pillar.zsh_profile.bake_script }}:
  file.managed:
    - source: salt://zsh-profile/bake-zprofiles.sh
    - template: jinja
    - makedirs: True
    - mode: 755

# Configure users
{% for _, user in pillar['users']['users'].items() %}

{% set home_dir = '/home/' + user.name %}
{% if user.name == 'root' %}
{% set home_dir = '/root' %}
{% endif %}

# Zsh profiles
{% set zsh_profiles_dir = home_dir + '/' + pillar['zsh_profile']['zsh_profiles_dir'] %}

{{ zsh_profiles_dir }}:
  file.recurse:
    - source: salt://zsh-profile/zprofile.d
    - clean: True
    - user: {{ user.name }}
    - group: {{ user.name }}
    - dir_mode: 755
    - file_mode: 755
    - template: jinja

{% set units_file = home_dir + '/' + pillar['zsh_profile']['units_file'] %}

{{ units_file }}:
  file.managed:
    - source: salt://zsh-profile/zprofile.units
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 650

bake_zsh_profiles-{{ user.name }}:
  cmd.run:
    - name: {{ pillar.zsh_profile.bake_script }}
    - runas: {{ user.name }}
    - onchanges:
      - file: {{ pillar.zsh_profile.bake_script }}
      - file: {{ zsh_profiles_dir }}
      - file: {{ units_file }}
    - require:
      - file: {{ zsh_profiles_dir }}
      - file: {{ pillar.zsh_profile.bake_script }}
      - file: {{ units_file }}

{% endfor %}
