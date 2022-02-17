# Create added keys parent directory
{{ pillar.users.added_keys_parent_directory }}:
  file.directory:
    - makedirs: True
    - dir_mode: 755

# Configure groups
{% for _, group in pillar['users']['groups'].items() %}
{{ group.name }}-group:
  group.present:
    - name: {{ group.name }}
    {%- if 'id' in group %}
    - gid: {{ group.id }}
    {% endif %}
{% endfor %}

# Configure users
{% for _, user in pillar['users']['users'].items() %}

# Create user
{{ user.name }}:
  user.present:
    - uid: {{ user.id }}
    - gid: {{ user.id }}
    - password: {{ user.password_hash }}
    - home: {{ user.home }}
    - shell: {{ pillar.users.shell }}
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
{% set ssh_dir = user.home + '/.ssh' %}
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
