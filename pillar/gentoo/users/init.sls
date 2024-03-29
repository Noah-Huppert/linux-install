users:
  shell: /bin/bash
  
  groups:
    docker:
      name: docker
      id: null
    wheel:
      id: null
    audio:
      id: null
    video:
      id: null
    pipewire:
      name: pipewire
      id: null
    docker:
      name: docker
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
