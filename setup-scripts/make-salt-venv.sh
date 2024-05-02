#!/usr/bin/env bash
readonly PROG_DIR=$(dirname $(realpath "$0"))
readonly VENV_DIR="$PROG_DIR/../.venv/"

python -m venv "$VENV_DIR"
source "$VENV_DIR/bin/activate"
pip3 install salt
