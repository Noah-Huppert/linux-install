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
    - network-utils
    - backlight
    #- thunderbolt
    #- pam
    #- polkit
    - fonts
    #- firewall
    #- power-management
    - bluetooth
    - ssdm
    - wireguard
    
    # User configuration
    - users
    - sudoers

    - home-directories
    
    - bash
    - which
    - shell-profile
    - pacman

    #- user-service-manager
    #- xdg-autostart

    # Development environment configuration
    - ssh
    - git
    - salt-apply-script
    - alacritty
    - kitty
    - c
    - cmake
    - kubectl
    #- ncdu
    - containers
    - go
    - flutter
    - terraform
    #- software-defined-radio
    - digitalocean-cli
    - godot
    #- dotnet
    #- ceph-client
    - dig
    - nmap
    - netcat
    - telnet
    #- insomnia
    - python
    - pipenv
    - aws-cli
    #- eksctl
    - java
    - android-sdk
    - salt-lint
    - jq
    - gtk-dev
    - unreal-engine
    - httpie
    - s3cmd
    - wireshark

    # General tools configuration
    - gpg
    - trash-cli
    - htop
    - flatpak
    - flameshot
    - spell-check
    
    # User interface configuration
    - vulkan
    - wayland
    - xdg-desktop-portal
    - start-wayland-script
    #- x11
    - wl-snip
    - rice
    - sway
    - hyprland
    - gnome-keyring
    - rsync
    - downgrade

    # Applications configuration
    #- links
    - firefox
    - chrome
    - syncthing
    - blender
    - emacs
    - vscode
    - signal
    - gimp
    - discord
    - openvpn
    - qbittorrent
    - k3s
    #- gnucash
    #- youtube-dl
    #- open-broadcaster-software
    - steam
    - steam-link
    #- tailscale
    - file-manager
    - ngrok
    - inkscape
    - vlc
    - mpv
    - anki
    - qgis
    - jetbrains-rider
    - hidclient
