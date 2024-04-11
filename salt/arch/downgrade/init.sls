# Install the downgrade package
downgrade_multipkg:
  multipkg.installed:
    - pkgs: {{ pillar.downgrade.multipkgs }}
