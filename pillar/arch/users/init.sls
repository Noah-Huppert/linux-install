users:
  groups:
    wheel:
      name: wheel
      id: null
    audio:
      name: audio
      id: null
    video:
      name: video
      id: null
    pipewire:
      name: pipewire
      id: null
    docker:
      name: docker
      id: null
    uucp: # USB serial ports are owned by this group
      name: uucp
      id: null

  users:
    noah:
      groups:
        linux_install: True
        wheel: True
        pipewire: True
        audio: False
        video: True
        docker: True
        uucp: True
