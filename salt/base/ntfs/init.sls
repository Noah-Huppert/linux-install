# Installs ntfs.
{% for pkg in pillar['ntfs']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}
