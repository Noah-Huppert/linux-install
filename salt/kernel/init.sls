# Install Linux kernel

# Install current version
{{ pillar.kernel.pkg }}:
  pkg.installed:
    - version: {{ pillar.kernel.version }}

# Uninstall old versions
{% for pkg in pillar['kernel']['old_pkgs'] %}
{{ pkg }}:
  pkg.removed
{% endfor %}
