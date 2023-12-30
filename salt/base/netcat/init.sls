# Installs Net Cat
netcat_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.netcat.pkgs }}
