# Installs the Digital Ocean CLI
doctl_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.doctl.pkgs }}
