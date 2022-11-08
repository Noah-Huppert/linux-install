{% for pkg in pillar['dbus']['pkgs'] %}
{{ pkg }}:
  pkg.installed
{% endfor %}