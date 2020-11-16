# Configures Bash

# Install a pre and post command shim
{{ pillar.bash.preexec.file }}:
  file.managed:
    - source: {{ pillar.bash.preexec.source }}
    - source_hash: {{ pillar.bash.preexec.source_hash }}
    - makedirs: True
    - mode: 755

# Create bash profile which sources the file made by the shell-profile state
{% for _, user in pillar['users']['users'].items() %}
{{ user.home }}/.bashrc:
  file.managed:
    - source: salt://bash/bashrc
    - mode: 600
{% endfor %}
