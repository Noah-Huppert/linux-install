# Installs the Cursor editor (https://www.cursor.com/)
cursor_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.cursor_editor.multipkgs }}
