# Installs Steam Link
flatpak install -y {{ pillar.steam_link.flatpak.repo }} {{ pillar.steam_link.flatpak.pkg }}:
  cmd.run:
    - unless: flatpak list | grep {{ pillar.steam_link.flatpak.pkg }}

{{ pillar.steam_link.desktop_file }}:
  file.managed:
    - source: salt://steam-link/steam-link.desktop
    - template: jinja