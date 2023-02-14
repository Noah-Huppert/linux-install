# Configures portage

{{ pillar.portage.base_dir }}/{{ pillar.portage.make_file }}:
  file.managed:
    - source: salt://portage/make.conf

{{ pillar.portage.base_dir }}/{{ pillar.portage.pkg_use_dir }}:
  file.recurse:
    - source: salt://portage/package.use/