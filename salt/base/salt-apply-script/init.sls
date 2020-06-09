# Install script which runs salt-call with customized options.

# Install
{{ pillar.salt_apply_script.file }}:
  file.managed:
    - source: salt://salt-apply-script/salt-apply
    - user: root
    - group: root
    - mode: 755

{{ pillar.salt_apply_script.old_file }}:
  file.absent
