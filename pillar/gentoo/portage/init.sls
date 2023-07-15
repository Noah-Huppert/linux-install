portage:
  # Module packages
  pkgs:
    - app-eselect/eselect-repository

    # cpuid2cpuflags reads your CPU arch and prints CPU_FLAGS_... USE values
    - app-portage/cpuid2cpuflags
    
  # Directory in which portage config files are located
  base_dir: /etc/portage

  # Path to make config file
  make_file: make.conf

  # Path to package specific use file directory
  pkg_use_dir: package.use

  pkg_accept_keywords_dir: package.accept_keywords

  # Path to package licenses file
  pkg_license_file: package.license

  # Extra repositories configuration
  repos_dir: repos.conf
