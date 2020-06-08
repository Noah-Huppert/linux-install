work:
  '*':
    - salt-configuration
    
    # User configuration
    - zsh

    - users
    - zsh-profile

    - sudoers
    - linux-install-repo
    - home-directories

    # Development environment configuration
    - emacs
    - scripts-repo
    - salt-apply-script

    # General tools configuration
    - gpg
    - git
    - ssh