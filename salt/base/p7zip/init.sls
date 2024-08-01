# Installs 7zip
p7zip_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.p7zip.pkgs }}

