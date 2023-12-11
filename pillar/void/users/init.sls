users:
  groups:
    wheel:
      name: wheel
      id: 4
    audio:
      name: audio
      id: 12
    video:
      name: video
      id: 13
    xbuilder:
      name: xbuilder
      id: 101
    lpadmin: # CUPS printer admin group
      name: lpadmin
      id: 976
    vboxusers:
      name: vboxusers
      id: 987
    bluetooth:
      name: bluetooth
      id: 990
    docker:
      name: docker
      id: 991
    movies: # Torrent destination directories
      name: movies

  users:
    noah:
      groups:
        linux_install: True
        wheel: True
        audio: True
        video: True
        xbuilder: True
        lpadmin: True
        vboxusers: True
        bluetooth: True
        docker: True
