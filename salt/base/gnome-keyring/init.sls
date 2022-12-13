# Installs gnome-keyring from xbps.
# src=SRC
{% for pkg in pillar['gnome_keyring']['xbps_gnome_keyring_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
