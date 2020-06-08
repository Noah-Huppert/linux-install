# Set permissions on linux-install repository locally.

{{ pillar.linux_install_repo.directory }}:
  file.directory:
    - user: {{ pillar.users.users[pillar.linux_install_repo.user].name }}
    - group: {{ pillar.users.users[pillar.linux_install_repo.user].name }}
    - recurse:
      - user
      - group
