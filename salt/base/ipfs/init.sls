# Install the IPFS CLI

{{ pillar.ipfs.dir.base }}:
  archive.extracted:
    - source: {{ pillar.ipfs.source_url }}
    - source_hash: {{ pillar.ipfs.source_sha256sum }}
    - enforce_toplevel: False

{{ pillar.ipfs.bin.link_dir }}/{{ pillar.ipfs.bin.file }}:
  file.symlink:
    - target: {{ pillar.ipfs.dir.base }}/{{ pillar.ipfs.dir.extracted }}/{{ pillar.ipfs.bin.file }}
    - mode: 755
    - require:
      - archive: {{ pillar.ipfs.dir.base }}

# Service
{% for _, user in pillar['users']['users'].items() %}
{% set svc_dir = user.home + '/' + pillar['user_services']['home_dir'] + '/ipfs' %}
{% set svc_run_file = svc_dir + '/run' %}
{% set svc_log_file = svc_dir + '/log/run' %}

{{ svc_run_file }}:
  file.managed:
    - source: salt://ipfs/run
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 755
    - makedirs: True

{{ svc_log_file }}:
  file.managed:
    - source: salt://ipfs/log
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 755
    - makedirs: True
    - defaults:
      user_name: {{ user.name }}

# Right now we don't want root to run ipfs at all
{% if user.name == 'root' %}
{{ svc_dir }}/down:
  file.touch:
    - makedirs: True
{% endif %}
{% endfor %}
