# Installs network utilities. Both the old network tools and the new network
# tools packages.

network_utils_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.network_utils.pkgs }}
