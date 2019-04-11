# Configure zzz hooks

{{ pillar.zzz.configuration_directory }}:
  file.recurse:
    - source: salt://zzz/zzz.d
    - file_mode: 755
    - dir_mode: 755
