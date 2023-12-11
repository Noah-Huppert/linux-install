# Installs support for exfat file systems.

exfat_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.exfat.pkgs }}
