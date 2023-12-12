# Install Firefox

{{ pillar.firefox.wayland_desktop_file }}:
  file.managed:
    - source: salt://firefox/firefox-wayland.desktop
    - template: jinja      
    - makedirs: True

firefox_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.firefox.pkgs }}
