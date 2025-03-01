# Installs the Firefox fork LibreWolf
librewolf_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.librewolf.multipkgs }}
