# Installs and sets up a desktop portal which lets apps running in wayland access system level resources like screen sharing
xdg_desktop_portal_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.xdg_desktop_portal.pkgs }}
