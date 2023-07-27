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
    - firewall
    - power-management
    
    # User configuration
    - users
    - sudoers
    - home-directories
    
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
    - terraform
    - software-defined-radio
    - digitalocean-cli
    - godot
    - dotnet
    - ceph-client
    - dig

    # General tools configuration
    - gpg
    - trash-cli
    - htop
    - flatpak
    
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
    - k3s
    - gnucash
    - youtube-dl
    - open-broadcaster-software
    - steam
    - steam-link