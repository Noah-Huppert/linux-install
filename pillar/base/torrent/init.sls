{% set transmission_core_pkg = 'transmission' %}

torrent:
  xbps_torrent_pkgs:
    - {{ transmission_core_pkg }}
    - transmission-qt
    - transmission-gtk

  transmission_core_pkg: {{ transmission_core_pkg }}
  transmission_file: .config/transmission/settings.json
  transmission_svc: transmission-daemon
  
  home_movies_dir: movies
