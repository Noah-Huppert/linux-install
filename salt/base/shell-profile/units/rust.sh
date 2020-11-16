# Adds Rust's package manager's binary path to the PATH
export PATH="$PATH:{{ pillar.rust.cargo_bin_substitute_path }}"
