# Install Flutter SDK

# Download
{{ pillar.flutter.download_file }}:
  file.managed:
    - source: {{ pillar.flutter.download_url }}
    - skip_verify: True
    - makedirs: True

{{ pillar.flutter.dir }}:
  archive.extracted:
    - source: {{ pillar.flutter.download_file }}
    - require:
      - file: {{ pillar.flutter.download_file }}

# Install
{{ pillar.flutter.install_file }}:
  file.symlink:
    - target: {{ pillar.flutter.install_target }}
    - require:
      - archive: {{ pillar.flutter.dir }}
