omnisharp:
  download:
    url: https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.39.1/omnisharp-linux-x64.tar.gz
    sha256sum: b0d9289ddfba52abde207fe13814e11c7770cd5453cd22568cf75e2d7cb5fd70
  install_dir: /opt/omnisharp
  symlink:
    create: /usr/local/bin/omnisharp
    target: /opt/omnisharp/run
