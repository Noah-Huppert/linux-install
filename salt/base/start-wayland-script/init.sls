# Installs a script which starts Wayland

{{ pillar.start_wayland_script.destination }}:
  file.managed:
    - source: salt://start-wayland-script/start-wayland
    - template: jinja
    - mode: 755
