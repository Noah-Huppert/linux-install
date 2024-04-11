# Installs s3cmd
s3cmd_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.s3cmd.pkgs }}

{% for conf in pillar['s3cmd']['conf_files'] %}
{{ conf.dest }}:
  file.managed:
    - source: {{ conf.source }}
    - user: {{ conf.owner }}
    - group: {{ conf.owner }}
{% endfor %}
