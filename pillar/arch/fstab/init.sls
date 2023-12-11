fstab:
  fstab_lines:
    - name: boot
      uuid_key: uuid
    - name: root
      uuid_key: luks_uuid
    - name: swap
      uuid_key: uuid

  top_comment: |
    # Static information about the filesystems.
    # See fstab(5) for details.

    # <file system> <dir> <type> <options> <dump> <pass>
