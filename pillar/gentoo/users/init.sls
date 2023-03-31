users:
  shell: /bin/bash
  
  groups:
    wheel:
      id: null
    audio:
      id: null
    video:
      id: null
    pipewire:
      name: pipewire
      id: null
    xbuilder: null
    lpadmin: null
    vboxusers: null
    bluetooth: null
    docker:
      name: docker
      id: null
    movies: null
    
  users:
    noah:
      groups:
        linux_install: True
        wheel: True
        pipewire: True
        audio: False
        video: True
        xbuilder: False
        lpadmin: False
        vboxusers: False
        bluetooth: False
        docker: True