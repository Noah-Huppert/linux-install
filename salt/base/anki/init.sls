# Installs Anki, a spaced repetition learning app
anki_pkgs:
  multipkg.installed:
    - pkgs: {{ pillar.anki.multi_pkgs }}
