# Installs openjdk8-jre from xbps.
# src=SRC
{% for pkg in pillar['java']['xbps_java_pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
