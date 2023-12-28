# Installs a file manager
file_manager_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.file_manager.pkgs }}
