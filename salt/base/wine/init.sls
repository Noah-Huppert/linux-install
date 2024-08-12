# Installs Wine
wine_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.wine.pkgs }}
