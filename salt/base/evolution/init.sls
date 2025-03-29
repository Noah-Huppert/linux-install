# Installs GNOME Evolution (all in one task organizer)
evolution_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.evolution.multipkgs }}
