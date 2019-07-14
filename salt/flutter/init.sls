# Install Flutter SDK

# Download
{{ pillar.flutter.download_file }}:
  file.managed:
    - source: {{ pillar.flutter.download_url }}
    - source_hash: {{ pillar.flutter.download_sha }}
    - user: noah
    - group: noah
    - makedirs: True

# Extract tar.gz        
{{ pillar.flutter.dir }}:
  archive.extracted:
    - source: {{ pillar.flutter.download_file }}
    - user: noah
    - group: noah
    - require:
      - file: {{ pillar.flutter.download_file }}

# Install
{{ pillar.flutter.install_file }}:
  file.symlink:
    - target: {{ pillar.flutter.install_target }}
    - require:
      - archive: {{ pillar.flutter.dir }}

# Install dependencies
{% for pkg in pillar['flutter']['dep_pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
