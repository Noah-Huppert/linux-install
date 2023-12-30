# Install and configure Refind to be the default bootloader

# Install refind
refind_pkg:
  pkg.installed:
    - name: {{ pillar.bootloader.refind.pkg }}

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
      - pkg: refind_pkg
      - file: {{ pillar.bootloader.check_refind_installed_script.file }}
      - file: {{ pillar.bootloader.run_check_refind_installed_script.file }}

# Refind configuration
{{ pillar.bootloader.refind.config_file }}:
  file.managed:
    - source: salt://bootloader/refind.conf
    - template: jinja
    - mode: 755
    - require:
      - cmd: refind-install
      {% if pillar['bootloader']['linux_bootloader_file'] is not none %}
      - file: {{ pillar.partitions.boot.mountpoint }}{{ pillar.bootloader.linux_bootloader_file }}
      {% endif %}
      - file: {{ pillar.partitions.boot.mountpoint }}{{ pillar.initramfs.file }}

{{ pillar.bootloader.refind.kernel_opts_file }}:
  file.managed:
    - source: salt://bootloader/refind_linux.conf
    - template: jinja
    - mode: 755
    - require:
      - cmd: refind-install

# Check we will be able to boot
# Sometimes the clean kernel script removes a file used by the bootloader,
# which then requires we use an external USB to rebuild these files.
# Hopefully this Salt check will fail if the boot partition is in a state where
# this could happen
{% if pillar['bootloader']['linux_bootloader_file'] is not none %}
{{ pillar.partitions.boot.mountpoint }}{{ pillar.bootloader.linux_bootloader_file }}:
  file.exists
{% endif %}
  
{{ pillar.partitions.boot.mountpoint }}{{ pillar.initramfs.file }}:
  file.exists
