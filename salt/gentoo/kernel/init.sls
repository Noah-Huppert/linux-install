# Install and select kernel
{% set kernel_name = "linux-" + pillar['kernel']['version'] + "-gentoo" %}

{{ pillar.kernel.src_pkg }}:
  pkg.installed:
    - version: {{ pillar.kernel.version }}

{{ pillar.kernel.main_dir }}:
  file.symlink:
    - target: {{ pillar.kernel.src_dir }}/{{ kernel_name }}
    - require:
      - pkg: {{ pillar.kernel.src_pkg }}

{% for config_path in pillar['kernel']['make_config_paths'] %}
{{ config_path }}:
  file.managed:
    - source: salt://kernel/make-config
    - require:
      - file: {{ pillar.kernel.main_dir }}
{% endfor %}