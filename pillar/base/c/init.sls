c:
  # Packages
  pkgs:
    # Compiler
    - gcc

    # Auto configure
    - autoconf

    # Build dependnecies
    - zlib-devel
    - libressl-devel

    # Debugger
    - gdb

    # Man pages
    - man-pages
    - man-pages-devel
    - man-pages-posix

    # Target 32-bits on 64-bit machine
    - gcc-multilib

    # Cross compile for Raspberry Pi's
    - cross-arm-linux-gnueabihf
