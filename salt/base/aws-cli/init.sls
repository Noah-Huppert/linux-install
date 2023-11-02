# Installs the AWS CLI
aws_cli_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.aws_cli.pkgs }}

# Configure credentials
{% for user in pillar['users']['users'].values() %}
{{ user.home }}/{{ pillar.aws_cli.home_dir_credentials_files }}:
  file.managed:
    - source: salt://aws-cli/credentials
    - makedirs: True
    - template: jinja
    - user: {{ user.name }}
    - group: {{ user.name }}
    - mode: 600
{% endfor %}
