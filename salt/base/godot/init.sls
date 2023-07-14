# Installs godot

# Download
{{ pillar.godot.install_dir }}:
  archive.extracted:
    - source: {{ pillar.godot.godot_dl.url }}
    - source_hash: {{ pillar.godot.godot_dl.sha256sum }}

{{ pillar.godot.bin.desktop }}:
  file.managed:
    - source: salt://godot/godot.desktop
    - template: jinja
