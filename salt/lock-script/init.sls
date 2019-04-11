# Install lock script

{{ pillar.lock_script.file }}:
  file.managed:
    - source: salt://lock-script/lock
    - makedirs: True
    - mode: 755

# Allow run with no sudo
{{ pillar.lock_script.sudo_config_file }}:
  file.managed:
    - source: salt://lock-script/sudoers.d/lock
    - template: jinja
    - check_cmd: visudo -c -f
    - makedirs: True
    - mode: 440
