# Installs wayland, sway, kde from xbps.
{% for pkg in pillar['wayland']['xbps_wayland_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

# Configure Eletron apps to run in Wayland
{% for key, user in pillar['users']['users'].items() %}
{{ user.home }}/.config/code-flags.conf:
  file.managed:
    - source: salt://wayland/electron-flags.conf
{% endfor %}