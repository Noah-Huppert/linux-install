# Install and configure GPG

# Install
{% for pkg in pillar['gpg']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

# Copy users keys
{% for user, key_id in pillar['gpg']['user_keys'].items() %}
{% set dir = '/home/' + user + '/' + pillar['gpg']['gpg_home_dir'] %}

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

# GPG Agent Configuration
{{ dir }}/{{ pillar.gpg.agent_config }}:
  file.managed:
    - source: salt://gpg/gpg-agent.conf
    - require:
      - file: {{ dir }}
{% endfor %}
