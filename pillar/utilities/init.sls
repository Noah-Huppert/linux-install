utilities:
  # XBPS utility packages
  xbps_pkgs:
    # XBPS tools
    - xtools
    
    # XDG tools
    - xdg-utils
    
    # Log viewer
    - lnav

    # Image tools
    - ImageMagick

    # System information retrieval
    - neofetch

    # Screenshot
    - scrot

    # Spell check
    - aspell
    - aspell-en

    # Document conversation tool
    - pandoc

    # Show filesystem tree
    - tree

    # Chroot for xbps-src
    - proot

    # Process monitor
    - htop

    # Trash can
    - trash-cli

    # Downloader
    - wget

    # Zip
    - unzip
    - zip

    # Rsync
    - rsync

    # Terraform
    - terraform

    # X Do Tool
    - xdotool
    
    # System call trace
    - strace

    # Provides dig tool
    - bind-utils

    # Keybase
    - keybase
    - keybase-desktop

    # File system change tools
    - inotify-tools

    # PostgreSQL client
    - postgresql-client

    # HTTPie HTTP CLI
    - httpie

    # Kubernetes CLI
    - kubectl

    # Local Kubernetes cluster
    - minikube

    # Virtual Box VM
    - virtualbox-ose

    # Network scanner
    - nmap

    # Serial terminal
    - screen
    - ppp

    # Helm
    - kubernetes-helm

    # Calculator
    - bc

    # GitHub CLI
    - hub

    - recordmydesktop

    # Needed to develop with the https://amethyst.rs game engine
    - alsa-lib
    - alsa-lib-devel
    - libX11-devel

    # File hex tool
    - xxd

    # Whois tool
    - whois

    # Calculator
    - kcalc

    # Telnet
    - inetutils-telnet

    # Packet captures
    - tcpdump

    # System call tracer & filterer
    - sysdig

    # Static site generator
    - hugo

  # Python 3 utility packages
  python3_pkgs:
    # Terminal CPU and memory graph
    - s-tui

    # Jupyter
    - jupyter
    - jupyterlab

    # Virtual environment manager
    - pipenv

    # Pylint
    - pylint

  # NodeJS utility packages
  node_pkgs:
    # VueJS CLI
    - '@vue/cli'

    # Firefox web extension development tool
    - web-ext

  # Git repository which will be cloned into ~/bin
  git_repos:
    - repo: https://github.com/Noah-Huppert/kiln.git
      dir: kiln

  # Go packages
  # Keys are expected bin names, values are go packages
  go_pkgs:
    dlv: github.com/go-delve/delve/cmd/dlv
    gorename: golang.org/x/tools/cmd/gorename
    gopls: golang.org/x/tools/cmd/gopls
