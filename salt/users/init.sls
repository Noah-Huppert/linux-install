# Bake Zsh profiles script
{{ pillar.users.bake_zsh_profiles_script }}:
  file.managed:
    - source: salt://users/bake-zprofiles.sh
    - makedirs: True
    - mode: 755

# Create added keys parent directory
{{ pillar.users.added_keys_parent_directory }}:
  file.directory:
    - makedirs: True
    - dir_mode: 755

# Configure groups
{% for _, group in pillar['users']['groups'].items() %}
{{ group.name }}:
  group.present:
    - gid: {{ group.id }}
{% endfor %}

# Configure users
{% for _, user in pillar['users']['users'].items() %}
{% set home_dir = '/home/' + user.name %}

# Create user
{{ user.name }}:
  user.present:
    - uid: {{ user.id }}
    - gid: {{ user.id }}
    - password: {{ user.password_hash }}
    - shell: {{ pillar.users.zsh_shell }}
    {%- if 'groups' in user %}
    - groups:
      {%- for group_key in user.groups %}
      - {{ pillar['users']['groups'][group_key]['name'] }}
      {%- endfor %}
    - require:
      {%- for group_key in user.groups %}
      - group: {{ pillar['users']['groups'][group_key]['name'] }}
      {%- endfor %}
    {%- endif %}

# SSH key
{% if 'ssh_key_name' in user %}
{% set ssh_dir = home_dir + '/.ssh' %}
{% set key_name = ssh_dir + '/' + user.ssh_key_name %}

{{ ssh_dir }}:
  file.directory:
    - makedirs: True
    - dir_mode: 700
    - user: {{ user.name }}
    - group: {{ user.name }}
    - require:
      - user: {{ user.name }}

{{ key_name }}:
  file.managed:
    - source: salt://users-secret/keys/{{ user.name }}/{{ user.ssh_key_name }}
    - mode: 600
    - user: {{ user.name }}
    - group: {{ user.name }}
    - require:
      - file: {{ ssh_dir }}

{{ key_name }}.pub:
  file.managed:
    - source: salt://users-secret/keys/{{ user.name }}/{{ user.ssh_key_name }}.pub
    - mode: 644
    - user: {{ user.name }}
    - group: {{ user.name }}
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
    - template: jinja
    - require:
      - user: {{ user.name }}

bake_zsh_profiles-{{ user.name }}:
  cmd.run:
    - name: {{ pillar.users.bake_zsh_profiles_script }}
    - user: {{ user.name }}
    - onchanges:
      - file: {{ zsh_profiles_dir }}
      - file: {{ pillar.users.bake_zsh_profiles_script }}
    - require:
      - file: {{ zsh_profiles_dir }}
      - file: {{ pillar.users.bake_zsh_profiles_script }}

# Create user specific added keys directory
{{ pillar.users.added_keys_parent_directory }}/{{ user.name }}:
  file.directory:
    - makedirs: True
    - dir_mode: 770
    - user: {{ user.name }}
    - group: {{ user.name }}
    - require:
      - file: {{ pillar.users.added_keys_parent_directory }}

{% endfor %}
