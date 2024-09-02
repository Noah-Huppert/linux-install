# Installs the XXD hex viewer
xxd_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.xxd.pkgs }}
