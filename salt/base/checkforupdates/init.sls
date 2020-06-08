# Install checkforupdates script.

# Install
{{ pillar.checkforupdates.file }}:
  file.managed:
    - source: salt://checkforupdates/checkforupdates
    - user: noah
    - group: noah
    - mode: 555

# Allow run with no sudo
{{ pillar.checkforupdates.sudo_configuration_file }}:
  file.managed:
    - source: salt://checkforupdates/sudoers.d/checkforupdates
    - template: jinja
    - check_cmd: visudo -c -f
    - makedirs: True
    - mode: 440
