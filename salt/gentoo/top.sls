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
    - internet
    
    # User configuration
    - users
    - sudoers
    
    - bash
    - shell-profile

    # Development environment configuration
    - git
    - salt-apply-script
    - alacritty

    # General tools configuration
    - gpg
    - trash-cli
    
    # User interface configuration
    - vulkan
    - wayland
    - start-wayland-script
    - sway
    - sway-launcher-desktop

    # Applications configuration
    - links
    - firefox