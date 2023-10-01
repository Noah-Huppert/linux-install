# Installs Flameshot, a screenshot tool
flameshot_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.flameshot.pkgs }}