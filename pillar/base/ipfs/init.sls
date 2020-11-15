ipfs:
  # Download
  source_url: https://dist.ipfs.io/go-ipfs/v0.7.0/go-ipfs_v0.7.0_linux-amd64.tar.gz
  source_sha256sum: ef7c3f1bcae94c13c6e1033855ff99bb8e19089e01ea5018437847854c8c811f

  # Install location
  dir:
    # Base directory to put other directories
    base: /opt/ipfs

    # Name of directory which will be extracted from the source archive
    extracted: go-ipfs

  # Symlink for CLI binary
  bin:
    link_dir: /usr/local/bin
    file: ipfs

  # User services
  
