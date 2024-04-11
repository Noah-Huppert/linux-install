# Install and configure flatpak

# Install
flatpak_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.flatpak.pkgs }}

# Configure
flatpak remote-add --if-not-exists flathub {{ pillar.flatpak.repository }}:
  cmd.run:
    - unless: bash -c '[ -z "$(flatpak remote-ls)" ] && exit 1; exit 0'
    - require:
      - pkg: flatpak_pkgs
