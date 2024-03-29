kernel:
  # Kernel package
  kernel_pkg: linux6.1

  # Old kernel package versions which should be uninstalled
  old_pkgs:
  {#   - linux5.15
    - linux5.15-headers #}

    - linux5.13
    - linux5.13-headers

    {# - linux5.12
    - linux5.12-headers #}

    - linux5.18
    - linux5.18-headers
    
    - linux5.11
    - linux5.11-headers
    
    - linux5.10
    - linux5.10-headers
    
    - linux5.9
    - linux5.9-headers
    
    - linux5.8
    - linux5.8-headers
    
    - linux5.7
    - linux5.7-headers
    
    - linux5.6
    - linux5.6-headers
    
    - linux5.5
    - linux5.5-headers
    
    - linux5.4
    - linux5.4-headers

    - linux5.3
    - linux5.3-headers

    - linux5.2
    - linux5.2-headers
    
    - linux5.1
    - linux5.1-headers
    
    - linux5.0
    - linux5.0-headers
    
    - linux4.20
    - linux4.20-headers
    
    - linux4.19
    - linux4.19-headers

  # Kernel package version
  version: 6.1.9_1
