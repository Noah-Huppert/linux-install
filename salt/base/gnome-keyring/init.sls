# Installs gnome-keyring.
{% for pkg in pillar['gnome_keyring']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
