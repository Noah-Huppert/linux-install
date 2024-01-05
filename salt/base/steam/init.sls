# Install Steam

steam_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.steam.pkgs }}
