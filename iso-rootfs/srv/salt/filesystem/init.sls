# Create an XFS filesystem in the root partition
create_root_fs:
  xfs.mkfs:
    - label: {{ partitions.root.label }}
