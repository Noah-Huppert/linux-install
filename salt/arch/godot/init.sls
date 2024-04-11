# Installs the Godot game engine
godot_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.godot.multipkgs }}
