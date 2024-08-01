# Installs Virtual Box
virtualbox_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.virtualbox.pkgs }}
