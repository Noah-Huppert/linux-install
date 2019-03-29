# Install and configure Refind to be the default bootloader

# Install refind
{{ pillar.bootloader.refind_pkg }}:
  pkg.installed

{{ pillar.bootloader.check_refind_installed_script.file }}:
  file.managed:
    - source: salt://bootloader/check-refind-installed.sh
    - template: jinja

refind-install:
  cmd.run:
    - unless: {{ pillar.bootloader.check_refind_installed_script.file }}
    - require:
      - pkg: {{ pillar.bootloader.refind_pkg }}
