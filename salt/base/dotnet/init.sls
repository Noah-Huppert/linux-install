{% for pkg in pillar['dotnet']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{{ pillar.dotnet.sdk_dir }}:
  archive.extracted:
    - source: {{ pillar.dotnet.sdk_url }}
    - source_hash: {{ pillar.dotnet.sdk_sha }}