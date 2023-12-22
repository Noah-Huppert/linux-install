# Installs GIMP
gimp_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.gimp.pkgs }}
