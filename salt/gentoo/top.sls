gentoo:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - kernel
    - genkernel
    - fstab
    - firmware

    # Higher level configuration
    - hostname
    - portage
    - ntp
    - timezone
    - internet
    - ntfs
    - exfat
    - audio
    - backlight
    
    # User configuration
    - users
    - sudoers
    
    - bash
    - shell-profile

    - user-service-manager

    # Development environment configuration
    - git
    - salt-apply-script
    - alacritty
    - ncdu

    # General tools configuration
    - gpg
    - trash-cli
    - htop
    
    # User interface configuration
    - vulkan
    - wayland
    - start-wayland-script
    - x11
    - sway
    - rice

    # Applications configuration
    - links
    - firefox
    - syncthing
    - blender
    - vscode