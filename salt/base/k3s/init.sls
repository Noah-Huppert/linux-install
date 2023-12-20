# Installs and configures K3S to run services locally

k3s_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.k3s.pkgs }}

k3s_aur_pkgs:
  aurpkg.installed:
    - pkgs: {{ pillar.k3s.aur_pkgs }}

{{ pillar.k3s.svc.install }}:
  file.managed:
    - source: salt://k3s/{{ pillar.k3s.svc.source }}
    - makedirs: True
    - require:
      - pkg: k3s_pkgs
      - aurpkg: k3s_aur_pkgs

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
    - makedirs: True
    - require:
      - pkg: k3s_pkgs
      - aurpkg: k3s_aur_pkgs
