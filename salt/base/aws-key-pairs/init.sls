# Place AWS key pairs on system

{{ pillar.aws_key_pairs.dir }}:
  file.recurse:
    - source: salt://aws-key-pairs-secret
    - user: noah
    - group: noah
    - file_mode: 600
    - dir_mode: 700
