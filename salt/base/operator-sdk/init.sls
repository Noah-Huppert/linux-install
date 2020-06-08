# Installs the Kubernetes Operator SDK

{{ pillar.operator_sdk.install_file }}:
  file.managed:
    - source: {{ pillar.operator_sdk.download_url }}
    - source_hash: {{ pillar.operator_sdk.download_sha }}
    - mode: 755
