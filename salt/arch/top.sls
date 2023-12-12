arch:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - kernel
    - fstab
    - firmware
    - bootloader

    # Higher level configuration
    - hostname
    - ntp
    - timezone
    - internet
    - ntfs
    - exfat
    - audio
    - yay
    #- backlight
    #- thunderbolt
    #- pam
    #- polkit
    - fonts
    #- firewall
    #- power-management
    #- bluetooth
    
    # User configuration
    - users
    - sudoers

    - home-directories
    
    - bash
    - shell-profile

    #- user-service-manager
    #- xdg-autostart

    # Development environment configuration
    - ssh
    - git
    - salt-apply-script
    - alacritty
    - c
    - cmake
    #- ncdu
    #- containers
    #- go
    #- flutter
    #- terraform
    #- software-defined-radio
    #- digitalocean-cli
    #- godot
    #- dotnet
    #- ceph-client
    #- dig
    #- insomnia
    #- python
    #- pipenv
    #- aws-cli
    #- eksctl
    #- java
    #- android-sdk

    # General tools configuration
    - gpg
    #- trash-cli
    - htop
    #- flatpak
    #- flameshot
    
    # User interface configuration
    #- vulkan
    - wayland
    - start-wayland-script
    #- x11
    - rice
    - sway
    #- hyprland
    #- gnome-keyring

    # Applications configuration
    #- links
    - firefox
    #- syncthing
    #- blender
    - emacs
    - vscode
    #- signal
    #- gimp
    #- discord
    #- openvpn
    #- qbittorrent
    #- k3s
    #- gnucash
    #- youtube-dl
    #- open-broadcaster-software
    #- steam
    #- steam-link
    #- tailscale
