# Installs ntfs.
ntfs_pkgs:
  pkg.installed:
    - pkgs: {{ pillar.ntfs.pkgs }} 
