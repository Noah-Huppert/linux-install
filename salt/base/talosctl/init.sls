# Installs the Talos linux command line interface
talos_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.talosctl.pkgs }}
