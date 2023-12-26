sway:
  app_launcher: wofi --show drun

  waybar_vpn_check_cmd: nmcli con show --active | grep vpn &> /dev/null

  waybar_modules:
    left:
      - sway/workspaces
      - sway/mode

    center:
      - wireplumber
      - backlight
      - network
      - custom/vpn

    right:
      - disk
      - battery
      - clock
  
  pkgs: 
    - sway
    - waybar

    # App Launcher
    - wofi
