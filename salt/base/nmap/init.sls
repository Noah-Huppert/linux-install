# Installs NMap
nmap_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.nmap.pkgs }}
