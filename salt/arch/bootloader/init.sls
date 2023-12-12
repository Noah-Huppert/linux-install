# Setups up the bootloader
{{ pillar.bootloader.boot_options_conf }}:
  file.managed:
    - source: salt://bootloader/refind_linux.conf
    - template: jinja
