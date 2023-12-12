# Installs the 'which' command
which_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.which.pkgs }}
