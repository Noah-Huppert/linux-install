{% for pkg in pillar['dotnet']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{{ pillar.dotnet.sdk_dir }}:
  archive.extracted:
    - source: {{ pillar.dotnet.sdk_url }}
    - source_hash: {{ pillar.dotnet.sdk_sha }}

{{ pillar.dotnet.link.destination }}:
  file.symlink:
    - target: {{ pillar.dotnet.link.source }}
    - depends_on:
      - archive: {{ pillar.dotnet.sdk_dir }}