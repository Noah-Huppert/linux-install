{% for pkg in pillar['vulkan']['pkgs'] %}
{{ pkg }}-installed:
  pkg.installed:
    - name: {{ pkg }}

{% endfor %}