fstab:
  # FStab file
  file: /etc/fstab

  # Defines which partitions should appear in the fstab file
  # Objects with keys:
  #   - name: Name of partition's key in pillar.partitions
  #   - uuid_key: Name of key in pillar.partitions.<name> from which to retrieve uuid
  fstab_lines: []

  top_comment: |
    # /etc/fstab: static file system information.
    #
    # noatime turns off atimes for increased performance (atimes normally aren't 
    # needed); notail increases performance of ReiserFS (at the expense of storage 
    # efficiency).  It's safe to drop the noatime options if you want and to 
    # switch between notail / tail freely.
    #
    # The root filesystem should have a pass number of either 0 or 1.
    # All other filesystems should have a pass number of 0 or greater than 1.
    #
    # See the manpage fstab(5) for more information.
    #

    # <fs>			<mountpoint>	<type>		<opts>		<dump/pass>

    # NOTE: If your BOOT partition is ReiserFS, add the notail option to opts.
    #
    # NOTE: Even though we list ext4 as the type here, it will work with ext2/ext3
    #       filesystems.  This just tells the kernel to use the ext4 driver.
    #
    # NOTE: You can use full paths to devices like /dev/sda3, but it is often
    #       more reliable to use filesystem labels or UUIDs. See your filesystem
    #       documentation for details on setting a label. To obtain the UUID, use
    #       the blkid(8) command.
