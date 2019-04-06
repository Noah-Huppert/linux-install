# Install Discord.

# Instal
flatpak install -y {{ pillar.discord.pak_download_url }}:
  cmd.run:
    - unless: flatpak list | grep discord

# Run script
{{ pillar.discord.run_script_file }}:
  file.managed:
    - source: salt://discord/discord
    - template: jinja
    - user: noah
    - group: noah
    - mode: 755