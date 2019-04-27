# Install and configure Digital Ocean CLI

# Install
{{ pillar.digitalocean_cli.pkg }}:
  pkg.latest

# Configure
{{ pillar.digitalocean_cli.configuration_file }}:
  file.managed:
    - source: salt://digitalocean-cli/config.yaml
    - template: jinja
    - makedirs: True
    - user: noah
    - group: noah
    - mode: 600
    - require:
      - pkg: {{ pillar.digitalocean_cli.pkg }}
