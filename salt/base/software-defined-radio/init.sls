# Install GNU Radio

{% for pkg in pillar['software_defined_radio']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
