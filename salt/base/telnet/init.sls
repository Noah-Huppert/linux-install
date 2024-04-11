# Installs telnet
telnet_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.telnet.pkgs }}
