# Installs and configures podman

{% for pkg in pillar['containers']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}

{{ pillar.containers.registries_cfg_file }}:
  file.managed:
    - source: salt://containers/registries.conf
    - mode: 644
