sway:
  app_launcher: wofi --show drun

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
    - wofi
