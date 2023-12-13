# Installs Signal desktop.
signal_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.signal.pkgs }}
