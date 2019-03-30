# Install and configure Refind to be the default bootloader

# Install refind
{{ pillar.bootloader.refind.pkg }}:
  pkg.installed

{{ pillar.bootloader.check_refind_installed_script.file }}:
  file.managed:
    - source: salt://bootloader/check-refind-installed.sh
    - makedirs: True
    - mode: 755

{{ pillar.bootloader.run_check_refind_installed_script.file }}:
  file.managed:
    - source: salt://bootloader/run-check-refind-installed.sh
    - template: jinja
    - makedirs: True
    - mode: 755

refind-install:
  cmd.run:
    - unless: {{ pillar.bootloader.run_check_refind_installed_script.file }}
    - require:
      - pkg: {{ pillar.bootloader.refind.pkg }}
      - file: {{ pillar.bootloader.check_refind_installed_script.file }}
      - file: {{ pillar.bootloader.run_check_refind_installed_script.file }}
