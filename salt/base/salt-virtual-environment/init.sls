# Salt virtual environment
{{ pillar.salt_virtual_environment.shortcut_script }}:
  file.managed:
    - source: salt://salt-virtual-environment/salt-call
    - mode: 755
    - template: jinja
