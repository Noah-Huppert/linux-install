# Installs network utilities. Both the old network tools and the new network
# tools packages.

{% for pkg in pillar['network_utils']['pkgs'] %}
{{ pkg }}:
  pkg.latest
{% endfor %}
