# Manual
Tracks changes which are being made manually so they can be automated in 
the future.

# Table Of Contents
- [Set Root Password](#set-root-password)
- [Boot Loader](#boot-loader)
- [Init RAM File System](#init-ram-file-system)
- [Fstab](#fstab)

# Set Root Password
```
passwd
```

# Boot Loader
Install Refind:

```
refind-install
```

Configure `/boot/efi/EFI/refind/refind.conf`:

```
scanfor internal,external,optical,manual,hdbios,biosexternal,cd

...

menuentry "Void" {
	volume "UUID=BOOT_PARTITION_UUID"
	loader /void-vmlinuz
	initrd /void-initramfs.img
	options "rd.luks.uuid=luks-ROOT_PARTITION_UUID root=/dev/mapper/luks-ROOT_PARTITION_UUID rd.lvm=0 rd.md=0 rd.dm=0 rd.auto rootfstype=ext4 rootflags=rw,relatime"
}
```

# Init RAM File System
Configure Dracut by adding the following configuration 
to `/etc/dracut.conf.d/00-crypt.conf`:

```
add_dracutmodules+=" crypt "
```

Generate initramfs:

```
dracut -f /boot/efi/void-initramfs.img LINUX_VERSION
```

# Fstab
Add entries to `/etc/fstab` file:

```
UUID=BOOT_PARTITION_UUID    /boot/efi    vfat    rw,relatime,codepage=437    0 2
```
