# Installs Blender 3D modeling software.

blender_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.blender.pkgs }}
