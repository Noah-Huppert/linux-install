# Create an XFS filesystem in the root partition
create_root_fs:
  blockdev.formatted:
    - name: {{ pillar.partitions.root.label }}
    - fs_type: ext4
