fstab:
  # FStab file
  file: /etc/fstab

  # Defines which partitions should appear in the fstab file
  # Objects with keys:
  #   - name: Name of partition's key in pillar.partitions
  #   - uuid_key: Name of key in pillar.partitions.<name> from which to retrieve uuid
  fstab_lines: []
