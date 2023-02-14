users:
  shell: /bin/bash
  
  groups:
    wheel:
      id: null
    audio:
      id: null
    video:
      id: null
    xbuilder: null
    lpadmin: null
    vboxusers: null
    bluetooth: null
    docker: null
    movies: null
    
  users:
    noah:
      groups:
        linux_install: True
        wheel: True
        audio: True
        video: True
        xbuilder: False
        lpadmin: False
        vboxusers: False
        bluetooth: False
        docker: False