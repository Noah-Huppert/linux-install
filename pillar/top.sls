base:
  '*':
    # Salt configuration
    - salt-configuration
    
    # Base system configuration
    - partitions
    - kernel
    - cleanup-kernel
    - exfat
    - initramfs
    - bootloader
    - fstab

    # Higher level system configuration
    - system-configuration
    - hostname
    - syslog
    - internet
    - internet-secret
    - xbps-configuration
    - ntp
    - touchpad
    - audio
    - backlight
    - bluetooth
    - fingerprint-reader
    - local-dns
    - local-dns.script
    - external-display
    - power-management

    # User level configuration
    - zsh 

    - users
    - users-secret
    - zsh-profile

    - sudoers
    - linux-install-repo
    - home-directories

    # Development environment configuration
    - build-deps
    - emacs
    - scripts-repo
    - scripts-repo-secret
    - salt-apply-script
    - c
    - cmake
    - pkg-config
    - go
    - python
    - elixir
    - nodejs
    - rust
    - aws-cli
    - aws-cli-secret
    - digitalocean-cli
    - digitalocean-cli-secret
    - red-hat-vpn
    - aws-key-pairs
    - openshift-client
    - android-sdk
    - flutter
    - argo
    - ngrok
    - operator-sdk
    - mbed
    - particle
    - dfu-util

    # General tools configuration
    - utilities
    - flatpak
    - gpg
    - git-secret
    - mercurial
    - ssh
    - vsv
    - checkforupdates
    - wireguard
    - wireguard-secret
#    - lock-script
    - kube-namespace
    - net-tools
    - vault
    - containers
    - freetype
    - expat
    - ncdu    
    - software-defined-radio

    # User interface configuration
    - xorg
    - i3
    - tmux
    - alacritty
    - compton
    - dunst
    - polybar
    - rice
    - fonts
 
    # Applications configurtion
    - misc-applications
    - firefox
    - slack
    - weechat
    - discord
    - blender
    - logisim
    - wireshark
    - tor
    - steam
    - chrome
    - cool-retro-term
