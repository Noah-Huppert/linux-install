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
    - thunderbolt
    - pam
    - polkit
    - fonts
    
    # User configuration
    - users
    - sudoers
    
    - bash
    - shell-profile

    - user-service-manager
    - xdg-autostart

    # Development environment configuration
    - git
    - salt-apply-script
    - alacritty
    - ncdu
    - containers
    - go
    - flutter

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
    - gnome-keyring

    # Applications configuration
    - links
    - firefox
    - syncthing
    - blender
    - vscode
    - signal
    - gimp
    - discord
    - openvpn
    - qbittorrent
