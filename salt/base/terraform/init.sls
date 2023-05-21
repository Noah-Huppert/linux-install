# Install Terraform
{% for pkg in pillar['terraform']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
