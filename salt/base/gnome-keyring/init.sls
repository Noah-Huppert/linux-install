# Installs gnome-keyring.
gnome_keyring_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.gnome_keyring.pkgs }}
