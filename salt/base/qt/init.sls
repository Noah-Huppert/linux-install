# Installs QT
qt_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.qt.pkgs }}
