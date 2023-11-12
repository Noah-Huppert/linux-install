gentoo:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - kernel
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
    - bluetooth
    
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
    - insomnia
    - python
    - pipenv
    - aws-cli
    - eksctl

    # General tools configuration
    - gpg
    - trash-cli
    - htop
    - flatpak
    - flameshot
    
    # User interface configuration
    - vulkan
    - wayland
    - start-wayland-script
    - x11
    - sway
    - hyprland
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
    - tailscale
