# Install Linux kernel

# Install kernel packages
{{ pillar.kernel.kernel_pkg }}:
  pkg.installed:
    - version: {{ pillar.kernel.version }}

{{ pillar.kernel.kernel_pkg }}-headers:
  pkg.installed:
    - version: {{ pillar.kernel.version }}

# Uninstall old versions
{% for pkg in pillar['kernel']['old_pkgs'] %}
{{ pkg }}:
  pkg.removed
{% endfor %}
