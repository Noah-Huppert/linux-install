work:
  '*':
    # Salt configuration
    - salt-configuration

    # Base system configuration
    - apt-repositories
    
    # User configuration
    - zsh
    - tmux

    - users
    - zsh-profile

    - sudoers
    - linux-install-repo
    - home-directories

    # Development environment configuration
    - emacs
    - tmux
    - scripts-repo
    - salt-apply-script
    - python
    #- rust

    # General tools configuration
    - gpg
    - git
    - ssh

    # User interface configuration
    #- alacritty
