xbps_configuration:
  # XBPS repository configuration
  repository:
    # Configuration file
    file: /usr/share/xbps.d/00-repository-main.conf

    # Repositories
    servers:
      # Main repository
      - 'http://mirror.clarkson.edu/voidlinux/current' # New York
      
      # Alternate tier 1 repositories
      - 'http://mirrors.servercentral.com/voidlinux/current' # Chicago
      - 'http://alpha.us.repo.voidlinux.org/current' # Kansas City

      # Alternate tier 2 repositories
      - 'http://www.gtlib.gatech.edu/pub/VoidLinux/current' # Atlanta

  # Main XBPS configuration file
  main_configuration_file: /usr/share/xbps.d/xbps.conf