rust:
  rustup:
    pkg: rustup
    init_cmd: rustup-init -y --no-modify-path
  pkgs:
    - rustup
    # Compiler
    #- rust

    # Package manager
    #- cargo

  cargo_bin_substitute_path: "$HOME/.cargo/bin"
