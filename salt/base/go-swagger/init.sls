# Install Go swagger
{{ pillar.go_swagger.path }}:
  file.managed:
    - source: {{ pillar.go_swagger.download_url }}
    - source_hash: {{ pillar.go_swagger.download_sha256 }}
    - mode: 755
