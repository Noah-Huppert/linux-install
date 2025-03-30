# Installs Strawberry music organizer (https://www.strawberrymusicplayer.org/)
strawberry_music_organizer_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.strawberry_music_organizer.multipkgs }}
