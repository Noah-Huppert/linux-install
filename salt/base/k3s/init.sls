# Installs and configures K3S to run services locally

{% for pkg in pillar['k3s']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{{ pillar.k3s.svc.install }}:
  file.managed:
    - source: salt://k3s/{{ pillar.k3s.svc.source }}
    - makedirs: True
    - requires:
      {% for pkg in pillar['k3s']['pkgs'] %}
      - pkg: {{ pkg }}
      {% endfor %}        

{{ pillar.k3s.auto_deploy_manifests_dir }}:
  file.recurse:
    - source: salt://k3s/manifests

{% for remote in pillar['k3s']['remote_manifests'] %}
{{ pillar.k3s.auto_deploy_manifests_dir }}/{{ remote.file }}:
  file.managed:
    - source: {{ remote.url }}
    - source_hash: {{ remote.sha }}
{% endfor %}

{{ pillar.k3s.config_file }}:
  file.managed:
    - source: salt://k3s/config.yaml
