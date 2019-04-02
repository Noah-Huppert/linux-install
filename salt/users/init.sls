# Bake Zsh profiles script
{{ pillar.users.bake_zsh_profiles_script }}:
  file.managed:
    - source: salt://users/bake-zprofiles.sh
    - makedirs: True
    - mode: 755

# Configure users
{% for _, user in pillar['users']['users'].items() %}
{% set home_dir = '/home/' + user.name %}

# Create user
{{ user.name }}:
  user.present:
    - password: {{ user.password_hash }}
    - shell: {{ pillar.user.zsh_shell }}

# SSH key
{% if 'ssh_key_name' in user %}
{% set ssh_dir = home_dir + '/.ssh' %}
{% set key_name = ssh_dir + '/' + user.ssh_key_name %}

{{ ssh_dir }}:
  file.directory:
    - makedirs: True
    - dir_mode: 700
    - require:
      - user: {{ user.name }}

{{ key_name }}:
  file.managed:
    - source: salt://users-secret/keys/{{ user.name }}/{{ user.ssh_key_name }}
    - mode: 600
    - require:
      - file: {{ ssh_dir }}

{{ key_name }}.pub:
  file.managed:
    - source: salt://users-secret/keys/{{ user.name }}/{{ user.ssh_key_name }}.pub
    - mode: 644
    - require:
      - file: {{ ssh_dir }}

{% endif %}

# Zsh profiles
{% set zsh_profiles_dir = home_dir + '/' + pillar['users']['zsh_profiles_dir'] %}

{{ zsh_profiles_dir }}:
  file.recurse:
    - source: salt://users/zprofile.d
    - user: {{ user.name }}
    - group: {{ user.name }}
    - dir_mode: 755
    - file_mode: 755
    - require:
      - user: {{ user.name }}

bake_zsh_profiles-{{ user.name }}:
  cmd.run:
    - name: {{ pillar.users.bake_zsh_profiles_script }}
    - user: {{ user.name }}
    - onchanges:
      - file: {{ zsh_profiles_dir }}
    - require:
      - file: {{ zsh_profiles_dir }}
      - file: {{ pillar.users.bake_zsh_profiles_script }}

{% endfor %}
