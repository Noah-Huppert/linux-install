s3cmd:
  pkgs: []
  conf_files:
    - source: salt://s3cmd/s3cfg
      dest: /home/noah/.s3cfg
      owner: noah
