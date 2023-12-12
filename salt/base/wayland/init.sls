# Installs wayland, sway, kde from xbps.
wayland_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.wayland.pkgs }}

# Configure Eletron apps to run in Wayland
{% for key, user in pillar['users']['users'].items() %}
{{ user.home }}/.config/code-flags.conf:
  file.managed:
    - source: salt://wayland/electron-flags.conf
{% endfor %}
