# Sets a user's timezone
{{ pillar.timezone.config_file }}:
  file.symlink:
    - target: {{ pillar.timezone.timezone_file }}