rust:
  # Rustup tool
  rustup:
    # Package
    pkg: rustup

    # Sets up rustup so it can be used later
    init_cmd: rustup-init -y --no-modify-path

    # Rust targets to install
    targets:
      - x86_64-unknown-linux-gnu
      - wasm32-unknown-unknown
      - wasm32-wasi

  # Latest version, used to ensure rust upgrades if not newest
  version: 1.47.0

  # Packages to install
  pkgs:
    - rustup

  # Location of rust binaries for users
  cargo_bin_substitute_path: "$HOME/.cargo/bin"
