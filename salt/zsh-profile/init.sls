# Bake Zsh profiles script
{{ pillar.zsh_profile.bake_script }}:
  file.managed:
    - source: salt://zsh-profile/bake-zprofiles.sh
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
    - user: {{ user.name }}
    - group: {{ user.name }}
    - dir_mode: 755
    - file_mode: 755
    - template: jinja
    - require:
      - user: {{ user.name }}

bake_zsh_profiles-{{ user.name }}:
  cmd.run:
    - name: {{ pillar.zsh_profile.bake_script }}
    - runas: {{ user.name }}
    - onchanges:
      - file: {{ pillar.zsh_profile.bake_script }}
      - file: {{ zsh_profiles_dir }}
    - require:
      - file: {{ zsh_profiles_dir }}
      - file: {{ pillar.zsh_profile.bake_script }}

{% endfor %}
