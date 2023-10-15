# Install and select kernel
{% set kernel_name = "linux-" + pillar['kernel']['version'] + "-gentoo" %}

{{ pillar.kernel.src_pkg }}:
  pkg.installed:
    - version: {{ pillar.kernel.version }}

kernel_tool_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.kernel.tool_pkgs }}

{{ pillar.kernel.main_dir }}:
  file.symlink:
    - target: {{ pillar.kernel.src_dir }}/{{ kernel_name }}
    - force: True
    - require:
      - pkg: {{ pillar.kernel.src_pkg }}

{% for config_path in pillar['kernel']['make_config_paths'] %}
{{ config_path }}:
  file.managed:
    - source: salt://kernel/make-config
    - require:
      - file: {{ pillar.kernel.main_dir }}
{% endfor %}

{{ pillar.kernel.modprobe_dir }}:
  file.recurse:
    - source: salt://kernel/modprobe.d/
    - clean: True

{{ pillar.kernel.kernel_config_file }}:
  file.managed:
    - source: salt://kernel/kernel.config

{{ pillar.kernel.genkernel_conf_file }}:
  file.managed:
    - source: salt://kernel/genkernel.conf

{{ pillar.kernel.dracut_conf_file_dir }}:
  file.recurse:
    - source: salt://kernel/dracut.conf.d/
    - clean: True

{{ pillar.kernel.vconsole_conf_file }}:
  file.managed:
    - source: salt://kernel/vconsole.conf
