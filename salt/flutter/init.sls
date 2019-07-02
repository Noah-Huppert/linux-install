# Install Flutter SDK

# Create group
{{ pillar.flutter.group }}-group:
  group.present:
    - name: {{ pillar.flutter.group }}
    - members:
      - noah

# Download
{{ pillar.flutter.dir }}-created:
  file.directory:
    - name: {{ pillar.flutter.dir }}
    - group: {{ pillar.flutter.group }}
    - dir_mode: 770
    - file_mode: 660
    - require:
      - group: {{ pillar.flutter.group }}-group
      
{{ pillar.flutter.download_file }}:
  file.managed:
    - source: {{ pillar.flutter.download_url }}
    - skip_verify: True
    - group: {{ pillar.flutter.group }}
    - require:
      - group: {{ pillar.flutter.group }}-group
      - file: {{ pillar.flutter.dir }}-created

{{ pillar.flutter.dir }}-extracted:
  archive.extracted:
    - name: {{ pillar.flutter.dir }}
    - source: {{ pillar.flutter.download_file }}
    - require:
      - file: {{ pillar.flutter.download_file }}

# Install
{{ pillar.flutter.install_file }}:
  file.symlink:
    - target: {{ pillar.flutter.install_target }}
    - require:
      - archive: {{ pillar.flutter.dir }}-extracted
