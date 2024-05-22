# Installs arduino tools
arduino_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.arduino.pkgs }}
