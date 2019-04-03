# Install vsv.

# Download
{{ pillar.vsv.repository }}:
  git.latest:
    - target: {{ pillar.vsv.directory }}
    - user: noah

# Man page
{{ pillar.vsv.global_man_file }}:
  file.managed:
    - source: {{ pillar.vsv.directory }}/{{ pillar.vsv.repo_man_file }}
    - mode: 644
    - require:
      - git: {{ pillar.vsv.repository }}

makewhatis {{ pillar.vsv.global_man_directory }}:
  cmd.run:
    - onchanges:
      - file: {{ pillar.vsv.global_man_file }}