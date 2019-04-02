# Configure fstab to auto mount boot directory

{{ pillar.fstab.file }}:
  file.managed:
    - source: salt://fstab/fstab
    - template: jinja
