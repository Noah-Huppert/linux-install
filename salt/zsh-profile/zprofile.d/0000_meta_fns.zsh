# Helper function for zsh units

function unit-die() {
    echo "Error: unit: $zsh_unit: $@" >&2
    return 1
}

function unit-echo() {
    echo "unit: $zsh_unit: $@"
}
