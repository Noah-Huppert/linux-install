base:
  '*':
    # Base system configuration
    - partitions
    - kernel
    - cleanup-kernel
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
    - external-display
    - power-management

    # User level configuration
    - zsh 
    - docker

    - users
    - users-secret
    - zsh-profile

    - sudoers
    - linux-install-repo
    - home-directories

    # Development environment configuration
    - emacs
    - scripts-repo
    - salt-apply-script
    - c
    - go
    - python
    - elixir
    - nodejs
    - aws-cli
    - aws-cli-secret
    - digitalocean-cli
    - digitalocean-cli-secret
    - red-hat-vpn
    - aws-key-pairs
    - openshift-client

    # General tools configuration
    - utilities
    - flatpak
    - gpg
    - git-secret
    - ssh
    - vsv
    - checkforupdates
    - wireguard
    - wireguard-secret
#    - lock-script
    - kube-namespace

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
