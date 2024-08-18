# Installs an IPMI CLI
ipmitool_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.ipmitool.pkgs }}
