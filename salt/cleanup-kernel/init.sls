# Install script which cleans up old Kernel files.

# Install
{{ pillar.cleanup_kernel.delete_script_file }}-managed:
  file.managed:
    - name: {{ pillar.cleanup_kernel.delete_script_file }}
    - source: salt://cleanup-kernel/cleanup-kernel.sh
    - makedirs: True
    - mode: 744

{{ pillar.cleanup_kernel.find_script_file }}:
  file.managed:
    - source: salt://cleanup-kernel/find-old-files.sh
    - makedirs: True
    - mode: 744

# Run
{{ pillar.cleanup_kernel.delete_script_file }}-run:
  cmd.run:
    - name: {{ pillar.cleanup_kernel.delete_script_file }} -v {{ pillar.kernel.version }}
    - unless: {{ pillar.cleanup_kernel.find_script_file }} -e -v {{ pillar.kernel.version }}
    - require:
      - file: {{ pillar.cleanup_kernel.find_script_file }}
      - file: {{ pillar.cleanup_kernel.delete_script_file }}-managed
