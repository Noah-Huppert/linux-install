# Installs Discord
discord_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.discord.pkgs }}
