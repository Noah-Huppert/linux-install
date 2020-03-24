# Install script which cleans up old Kernel files.

# Install
{{ pillar.cleanup_kernel.delete_script_file }}-managed:
  file.managed:
    - name: {{ pillar.cleanup_kernel.delete_script_file }}
    - source: salt://cleanup-kernel/cleanup-kernel.sh
    - makedirs: True
    - mode: 744

# Run
{{ pillar.cleanup_kernel.delete_script_file }}-run:
  cmd.run:
    - name: {{ pillar.cleanup_kernel.delete_script_file }}
    - unless: {{ pillar.cleanup_kernel.delete_script_file }} -d
    - require:
      - file: {{ pillar.cleanup_kernel.delete_script_file }}-managed
