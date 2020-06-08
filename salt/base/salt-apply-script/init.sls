# Install script which runs salt-call with customized options.

# Install
{{ pillar.salt_apply_script.file }}:
  file.managed:
    - source: salt://salt-apply-script/salt-apply
    - user: noah
    - group: noah
    - mode: 755