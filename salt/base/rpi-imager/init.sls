# Installs the Raspberry Pi Imaging tool
rpi_imager_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.rpi_imager.pkgs }}
