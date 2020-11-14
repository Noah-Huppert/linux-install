# Install the IPFS CLI

{{ pillar.ipfs.dir.base }}:
  archive.extracted:
    - source: {{ pillar.ipfs.source_url }}
    - source_hash: {{ pillar.ipfs.source_sha256sum }}
    - enforce_toplevel: False

{{ pillar.ipfs.bin.link_dir }}/{{ pillar.ipfs.bin.file }}:
  file.symlink:
    - target: {{ pillar.ipfs.dir.base }}/{{ pillar.ipfs.dir.extracted }}/{{ pillar.ipfs.bin.file }}
    - mode: 755
    - require:
      - archive: {{ pillar.ipfs.dir.base }}
