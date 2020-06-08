syslog:
  # System log package
  pkg: socklog-void

  # System log services
  svcs:
    # System log unix socket service
    - socklog-unix

    # Kernel log service
    -  nanoklogd
