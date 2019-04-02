# Install and configure GPG

# Install
gnupg2:
  pkg.installed

# Copy users keys
{% for user, key_id in pillar['gpg']['user_keys'].items() %}
{% set dir = '/home/' + user + '/.gnupg' %}

# Make Gnupg directory
{{ dir }}:
  file.directory:
    - makedirs: True
    - dir_mode: 700
    - user: {{ user }}
    - group: {{ user }}

# Copy temp asc files for import
{% for gpg_f in pillar['gpg']['import_files'].values() %}
{{ dir }}/{{ gpg_f }}:
  file.managed:
    - source: salt://gpg-secret/{{ user }}/{{ gpg_f }}
    - user: {{ user }}
    - group: {{ user }}
    - mode: 600
    - require:
      - file: {{ dir }}
{% endfor %}
{% endfor %}
