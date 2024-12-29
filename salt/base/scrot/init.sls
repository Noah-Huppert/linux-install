# Installs scrot to take screenshots in X11
scrot_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.scrot.pkgs }}
