base:
  '*':
    # Base system configuration
    - partitions
    - kernel
    - initramfs
    - bootloader
    - fstab

    # Higher level system configuration
    - system-configuration
    - hostname
    - internet
    - internet-secret
    - xbps-configuration
    - ntp
    - touchpad
    - audio
    - backlight

    # User level configuration
    - zsh 

    - users
    - users-secret

    - sudoers
    - linux-install-repo
    - home-directories

    # Applications and tools
    - xorg
    - i3
    - compton
    - dunst
    - polybar
    - rice

    - alacritty
    - tmux
    - utilities
    - flatpak

    - gpg
    - git-secret
    - vsv
    - emacs
    - scripts-repo
    - salt-apply-script

    - misc-applications
    - firefox
    - slack