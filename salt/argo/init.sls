# Installs Argo CLI
# https://argoproj.github.io

{{ pillar.argo.install_file }}:
  file.managed:
    - source: {{ pillar.argo.download_url }}
    - source_hash: {{ pillar.argo.download_sha }}
    - mode: 755
