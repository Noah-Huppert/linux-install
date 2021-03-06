# Install Slack.

# Instal
flatpak install -y {{ pillar.slack.pak_download_url }}:
  cmd.run:
    - unless: flatpak list | grep slack

# Run script
{{ pillar.slack.run_script_file }}:
  file.managed:
    - source: salt://slack/slack
    - template: jinja
    - user: noah
    - group: noah
    - mode: 755