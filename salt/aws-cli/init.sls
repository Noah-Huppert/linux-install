# Install and configure AWS CLI

# Install
{{ pillar.aws_cli.pip_pkg }}:
 pip.installed:
   - pip_bin: {{ pillar.python.pip3_bin }}

# Configure credentials
{{ pillar.aws_cli.credentials_file }}:
  file.managed:
    - source: salt://aws-cli/credentials
    - makedirs: True
    - template: jinja
    - user: noah
    - group: noah
    - mode: 600
