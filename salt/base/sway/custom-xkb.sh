#!/usr/bin/env bash
# Print current layout
xkb_error() {
    echo "{ \"text\": \"XKB error\" }"
    exit 1
}

layout=$(xkb-switch -p) || xkb_error

echo "{ \"text\": \"$layout\" }"
