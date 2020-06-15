python:
  # Packages
  pkgs:
    - __: overwrite
  
    # Python 2
    - python2
    #- python2-pip: pkg doesn't exist, need to use get-pip.py script if we need pip2
    - python2-dev

    # Python 3
    - python3
    - python3-pip
    - python3-dev

