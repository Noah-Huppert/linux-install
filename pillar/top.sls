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

    # General tools configuration
    - utilities
    - flatpak
    - gpg
    - git-secret
    - vsv
    - checkforupdates

    # Development environment configuration
    - emacs
    - scripts-repo
    - salt-apply-script
    - python

    # User interface configuration
    - xorg
    - i3
    - tmux
    - alacritty
    - compton
    - dunst
    - polybar
    - rice
 
    # Applications configurtion
    - misc-applications
    - firefox
    - slack