# Install Firefox

{{ pillar.firefox.wayland_desktop_file }}:
  file.managed:
    - source: salt://firefox/firefox-wayland.desktop
    - makedirs: True

{% for pkg in pillar['firefox']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
