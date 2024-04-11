# Installs QGIS

qgis_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.qgis.multipkgs }}
