power_management:
  # zzz configuration directory
  zzz_configuration_directory: /etc/zzz.d/

  # Service which suspends laptop on lid close
  suspend_svc: acpid

  # The laptop power management tool
  tlp:
    # Package
    pkg: tlp

    # Service
    svc: tlp
