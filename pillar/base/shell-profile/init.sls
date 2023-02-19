shell_profile:
  # Script to assemble all shell units into one file
  bake_script: /opt/bake-profiles/bake-profiles.sh

  # Directory in user's home directory to store raw shell units
  shell_profiles_dir: .profile.d

  # File which indicates which shell units to include
  units_file: .profile.units

  # Shell units to include in the units_file
  shell_units: []